# GitHub + AWS connection checklist

## 1. Repository

Repository: `morisoleimani/secure-aws-devsecops`

## 2. Immutable OIDC IDs

This repository was created after July 15, 2026, so GitHub uses immutable OIDC subject claims. Terraform accepts the GitHub owner ID and repository ID as variables.

## 3. Terraform variables

```bash
export TF_VAR_github_org="morisoleimani"
export TF_VAR_github_owner_id="317796901"
export TF_VAR_github_repo="secure-aws-devsecops"
export TF_VAR_github_repo_id="1336818680"
export TF_VAR_aws_region="eu-central-1"
```

## 4. AWS bootstrap

Run `infrastructure/bootstrap` first to create the private, versioned, KMS-encrypted Terraform state bucket. Then initialize the main stack using the bucket name as partial backend configuration.

## 5. GitHub Environments

Create `staging` and `production`. Protect `production` with required reviewers.

Set environment variables:

### staging
- `AWS_DEPLOY_ROLE_ARN`
- `AWS_ACCOUNT_ID`
- `AWS_REGION`
- `ECR_REPOSITORY`

### production
- `AWS_DEPLOY_ROLE_ARN`
- `AWS_ACCOUNT_ID`
- `AWS_REGION`
- `ECR_REPOSITORY`
- `STAGING_ECR_REPOSITORY`

Do not create AWS access-key secrets. The workflows use GitHub OIDC and short-lived AWS credentials.

## 6. Protect main

Require CI and Security checks before merging. Restrict production deployment to the protected environment.
