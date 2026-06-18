terraform {
  backend "s3" {
    bucket = "agent-demo-bucket7723"
    key    = "eks/{{name}}-dev/terraform.tfstate"
    region = "us-east-1"
  }
}
