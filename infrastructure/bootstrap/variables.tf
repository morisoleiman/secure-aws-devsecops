variable "aws_region" {
  type        = string
  description = "AWS region for the Terraform state bucket."
  default     = "eu-central-1"
}

variable "state_bucket_name" {
  type        = string
  description = "Globally unique private S3 bucket name for Terraform state."
}
