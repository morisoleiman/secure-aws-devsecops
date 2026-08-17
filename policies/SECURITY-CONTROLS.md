# Security Controls Matrix

| Control | Implementation | Gate |
|---|---|---|
| Long-lived AWS keys | GitHub OIDC | Required |
| OIDC trust scope | repository + environment subject | Required |
| IAM permissions | least privilege for ECR | Required |
| Secret leakage | Gitleaks | Required |
| SAST | CodeQL | Required |
| Dependency CVEs | pip-audit + Dependabot | Required |
| IaC misconfiguration | Checkov | Required |
| Container CVEs | Trivy HIGH/CRITICAL | Required |
| Production access | protected GitHub Environment | Required |
| Workflow permissions | explicit least privilege | Required |

## Terraform state

Terraform state is stored in a dedicated private S3 state bucket with KMS encryption, versioning, TLS-only access policy, and S3 lockfile state locking. Bootstrap is performed separately before the main stack is initialized; credentials must never be committed to the repository.
