# Supply Chain Defense: Cryptographic SBOM Attestation in Azure Container Registries

[![Pester Verification](https://img.shields.io/badge/pester-16%2F16%20passing-brightgreen)](tests/SbomAttestation.Tests.ps1)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Architecture Deep-Dive](https://img.shields.io/badge/blog-alerasoul.net-0a1128)](https://alerasoul.net/platform-sbom-attestation-admission-pipeline/)

> **Primary Governance Artefact:** Automated SBOM Generation & Cryptographic Attestation Admission Policy  
> **Accountable Service Owner:** Lead DevSecOps Architect & Platform Security Officer  
> **Full Architectural Deep-Dive:** [https://alerasoul.net/platform-sbom-attestation-admission-pipeline/](https://alerasoul.net/platform-sbom-attestation-admission-pipeline/)

---

## Repository Layout (13 Files)

```text
├── .github/workflows/sign-and-attest.yml
├── .gitignore
├── LICENSE
├── README.md
├── SECURITY.md
├── docs/SLSA-ATTESTATION-RUNBOOK.md
├── fixtures/spdx-sbom-manifest.json
├── infra/acr-quarantine-webhook.bicep
├── policies/notation-trustpolicy.json
├── policies/ratify-gatekeeper-constraint.yaml
├── queries/Aks-UnsignedImage-Blocks.kql
├── src/Test-ContainerSbomAdmissionPolicy.ps1
└── tests/SbomAttestation.Tests.ps1
```

## Quickstart & Offline Verification

```powershell
# 1. Execute the primary PowerShell 7 evaluator
pwsh -NoProfile -File ./src/Test-ContainerSbomAdmissionPolicy.ps1

# 2. Run the 16-test Pester verification contract
Invoke-Pester -Path ./tests/SbomAttestation.Tests.ps1 -Output Detailed
```

## License

Released under the [MIT License](LICENSE). Authored by **Shahrad Alerasoul** ([alerasoul.net](https://alerasoul.net)).
