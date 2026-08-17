variable "aws_region" {
  type        = string
  description = "AWS deployment region."
  default     = "eu-central-1"
}

variable "github_org" {
  type        = string
  description = "GitHub organization or user that owns the repository."
}

variable "github_repo" {
  type        = string
  description = "GitHub repository name."
}

variable "github_owner_id" {
  type        = string
  description = "Immutable GitHub owner ID used in the OIDC subject claim."
}

variable "github_repo_id" {
  type        = string
  description = "Immutable GitHub repository ID used in the OIDC subject claim."
}

variable "github_oidc_provider_url" {
  type        = string
  description = "GitHub Actions OIDC issuer URL."
  default     = "https://token.actions.githubusercontent.com"
}

variable "github_oidc_audience" {
  type        = string
  description = "AWS STS audience used by GitHub Actions OIDC."
  default     = "sts.amazonaws.com"
}
