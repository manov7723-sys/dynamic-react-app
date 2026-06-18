terraform {
  backend "s3" {
    bucket = "agent-demo-bucket7723"
    key    = "eks/app-cluster-prod/terraform.tfstate"
    region = "us-east-1"
  }
}
