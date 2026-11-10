# ADR-001: Supply Chain Defense: Cryptographic SBOM Attestation in Azure Container Registries

## Status
Accepted

## Service Owner & Sign-Off Authority
Lead DevSecOps Architect & Platform Security Officer

## Dominant Artefact
Automated SBOM Generation & Cryptographic Attestation Admission Policy

## Decision & Refusal Boundary
All production state mutations must pass deterministic pre-flight policy evaluation in `src/Test-ContainerSbomAdmissionPolicy.ps1` and satisfy the 16-test Pester verification contract in `tests/Boundary-Verification.Tests.ps1` before execution.
