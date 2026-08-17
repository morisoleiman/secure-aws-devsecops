output "aws_account_id" {
  value       = data.aws_caller_identity.current.account_id
  description = "AWS account ID."
}

output "staging_role_arn" {
  value       = aws_iam_role.staging.arn
  description = "GitHub Actions staging role ARN."
}

output "production_role_arn" {
  value       = aws_iam_role.production.arn
  description = "GitHub Actions production role ARN."
}

output "oidc_provider_arn" {
  value       = aws_iam_openid_connect_provider.github.arn
  description = "GitHub Actions OIDC provider ARN."
}

output "staging_ecr_repository_url" {
  value       = aws_ecr_repository.staging.repository_url
  description = "Staging ECR repository URL."
}

output "production_ecr_repository_url" {
  value       = aws_ecr_repository.production.repository_url
  description = "Production ECR repository URL."
}
