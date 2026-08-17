# Secure AWS DevSecOps Pipeline

Security-first AWS CI/CD reference project using GitHub Actions, Terraform, GitHub OIDC, SAST, dependency auditing, IaC scanning and container scanning.

## Security architecture

- GitHub Actions authenticates to AWS through OIDC; no long-lived AWS credentials are stored in GitHub.
- OIDC trust is restricted to this repository and the `staging` or `production` environment.
- ECR repositories use immutable tags and scan on push.
- Pull requests run unit tests, secret scanning, CodeQL, dependency auditing, Checkov and Trivy.
- Production promotes the exact immutable staging image instead of rebuilding it.
- Terraform state is intended for a dedicated encrypted/versioned S3 bucket with lockfile state locking.

## Repository

`morisoleimani/secure-aws-devsecops`

## Local validation

```bash
./scripts/validate.sh
```

## AWS setup

See `GITHUB-AWS-SETUP.md` for the OIDC and AWS bootstrap procedure.
