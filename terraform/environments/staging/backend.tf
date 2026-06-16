terraform {
  backend "s3" {
    bucket = "agent-demo-bucket7723"
    key    = "eks/my-eks-cluster-staging/terraform.tfstate"
    region = "us-east-1"
  }
}
