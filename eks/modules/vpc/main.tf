data "aws_availability_zones" "available" {
  state = "available"
}

# Generate N public + N private subnet CIDRs across N AZs from the subnet_count.
# The registry VPC module then creates the subnets, Internet Gateway, NAT gateway(s),
# route tables, and all associations automatically.
locals {
  azs             = slice(data.aws_availability_zones.available.names, 0, var.subnet_count)
  private_subnets = [for i in range(var.subnet_count) : cidrsubnet(var.cidr, 4, i)]
  public_subnets  = [for i in range(var.subnet_count) : cidrsubnet(var.cidr, 4, i + 8)]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.name
  cidr = var.cidr

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = true

  public_subnet_tags  = { "kubernetes.io/role/elb" = 1 }
  private_subnet_tags = { "kubernetes.io/role/internal-elb" = 1 }

  tags = var.tags
}
