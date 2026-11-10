# Test-ContainerSbomAdmissionPolicy.ps1
[CmdletBinding()]
param(
    [Parameter(Mandatory)] [PSCustomObject]$PodImageSpec
)

$ErrorActionPreference = 'Stop'

# 1. Hard Veto on Mutable Image Tags (Must use immutable @sha256:<64-hex> digest)
if ($PodImageSpec.ImageReference -notmatch '@sha256:[a-f0-9]{64}$') {
    return [PSCustomObject]@{
        ImageReference = $PodImageSpec.ImageReference
        Admission      = 'DENY_MUTABLE_IMAGE_TAG'
        Permitted      = $false
        Reason         = 'Pod specification must reference an immutable @sha256 digest, not a mutable tag.'
    }
}

# 2. Hard Veto on Missing or Invalid Cosign Cryptographic Signature
if (-not $PodImageSpec.HasValidCosignSignature -or $PodImageSpec.SigningKeyVaultUri -notmatch 'kv-sovereign-signing') {
    return [PSCustomObject]@{
        ImageReference = $PodImageSpec.ImageReference
        Admission      = 'DENY_UNSIGNED_OR_UNTRUSTED_PROVENANCE'
        Permitted      = $false
        Reason         = 'Image digest lacks a valid Cosign signature from the production signing Key Vault.'
    }
}

# 3. Hard Veto on Missing CycloneDX SBOM or Critical CVE Breach
if (-not $PodImageSpec.HasAttachedCycloneDxSbom -or $PodImageSpec.CriticalCveCount -gt 0) {
    return [PSCustomObject]@{
        ImageReference = $PodImageSpec.ImageReference
        Admission      = 'DENY_SBOM_MISSING_OR_CRITICAL_CVE'
        Permitted      = $false
        Reason         = "Image is missing an OCI-attached CycloneDX SBOM or contains Critical CVEs (Count: $($PodImageSpec.CriticalCveCount))."
    }
}

return [PSCustomObject]@{
    ImageReference = $PodImageSpec.ImageReference
    Admission      = 'PERMIT_VERIFIED_CONTAINER_ADMISSION'
    Permitted      = $true
}
