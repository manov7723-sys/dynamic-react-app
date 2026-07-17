terraform {
  required_version = ">= 1.4"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.60" }
  }
}

# Two aliased AWS providers — one per region. The peering RESOURCE lives in
# the left region (the requester); the ACCEPTER lives in the right region.
provider "aws" {
  alias  = "left"
  region = "us-east-1"
}

provider "aws" {
  alias  = "right"
  region = "us-east-2"
}
