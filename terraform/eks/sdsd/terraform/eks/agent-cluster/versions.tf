terraform {
  required_version = ">= 1.5.0"
  # No S3 backend configured — state is local. Set a Terraform state
  # bucket on the Infrastructure page for production use.
  required_providers {
    aws      = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}
