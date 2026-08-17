output "state_bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "Terraform state bucket name."
}

output "state_kms_key_arn" {
  value       = aws_kms_key.terraform_state.arn
  description = "KMS key used to encrypt Terraform state."
}
