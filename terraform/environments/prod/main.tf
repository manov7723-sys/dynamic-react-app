module "vpc" {
  count  = var.create_vpc ? 1 : 0
  source = "../../modules/vpc"

  name               = "${var.cluster_name}-vpc"
  cidr               = var.vpc_cidr
  subnet_count       = var.subnet_count
  single_nat_gateway = var.single_nat_gateway
  tags               = var.tags
}

# Resolve which subnets the cluster + nodes use, for BOTH paths:
#   • new VPC  → subnets created above (nodes land in private or public per node_subnet_type)
#   • existing → the comma-separated subnet IDs the user supplied
locals {
  new_private = try(module.vpc[0].private_subnets, [])
  new_public  = try(module.vpc[0].public_subnets, [])

  existing_cluster_subnets = compact(split(",", replace(var.existing_subnet_ids, " ", "")))
  existing_node_subnets    = compact(split(",", replace(var.existing_node_subnet_ids, " ", "")))

  cluster_subnet_ids = var.create_vpc ? concat(local.new_private, local.new_public) : local.existing_cluster_subnets
  node_subnet_ids = var.create_vpc ? (
    var.node_subnet_type == "public" ? local.new_public : local.new_private
  ) : local.existing_node_subnets
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
  subnet_ids       = local.cluster_subnet_ids
  node_subnet_ids  = local.node_subnet_ids

  instance_type          = var.instance_type
  desired_size           = var.desired_size
  min_size               = var.min_size
  max_size               = var.max_size
  endpoint_public_access = var.endpoint_public_access
  public_access_cidrs    = var.public_access_cidrs
  node_disk_size         = var.node_disk_size
  admin_principal_arns   = var.admin_principal_arns

  tags = var.tags

  depends_on = [module.iam]
}
