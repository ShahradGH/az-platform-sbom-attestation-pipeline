# Operational Runbook: Supply Chain Defense: Cryptographic SBOM Attestation in Azure Container Registries (L2 / L3 Triage)

## 1. Scope & Ownership
- **Accountable Owner**: Lead DevSecOps Architect & Platform Security Officer
- **Primary Evaluator**: `src/Test-ContainerSbomAdmissionPolicy.ps1`
- **Telemetry Source**: `diagnostics/Telemetry-Queries.kql`

## 2. Triage Procedure When Veto Gate Trips
1. Inspect the structured refusal object emitted by `src/Test-ContainerSbomAdmissionPolicy.ps1` and correlate the timestamp in Azure Monitor Log Analytics.
2. Do not bypass or disable the pre-flight policy gate without cryptographic dual-signature approval from the Lead DevSecOps Architect & Platform Security Officer.
3. Verify remediation locally by running `Invoke-Pester -Path ./tests/Boundary-Verification.Tests.ps1 -Output Detailed`.
