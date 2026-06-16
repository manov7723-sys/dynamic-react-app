terraform {
  backend "s3" {
    bucket = "agent-demo-bucket7723"
    key    = "eks/dev-my-cluster-dev/terraform.tfstate"
    region = "us-east-1"
  }
}
