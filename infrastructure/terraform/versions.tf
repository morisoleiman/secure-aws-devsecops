terraform {
  required_version = ">= 1.10.0, < 2.0.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 6.0" }
    tls = { source = "hashicorp/tls", version = "~> 4.0" }
  }

  backend "s3" {
    key          = "secure-aws-devsecops/terraform.tfstate"
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project   = "secure-aws-devsecops"
      ManagedBy = "terraform"
      Security  = "hardened"
    }
  }
}
