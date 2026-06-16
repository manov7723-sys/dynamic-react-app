module "vpc" {
  source = "../../modules/vpc"

  name               = "${var.cluster_name}-vpc"
  cidr               = var.vpc_cidr
  single_nat_gateway = var.single_nat_gateway
  tags               = var.tags
}

module "iam" {
  source = "../../modules/iam"

  name = var.cluster_name
  tags = var.tags
}

module "eks" {
  source = "../../modules/eks"

  name             = var.cluster_name
  k8s_version      = var.k8s_version
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
  subnet_ids       = module.vpc.private_subnets

  instance_type          = var.instance_type
  desired_size           = var.desired_size
  min_size               = var.min_size
  max_size               = var.max_size
  endpoint_public_access = var.endpoint_public_access

  tags = var.tags
}
