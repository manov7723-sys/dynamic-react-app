locals {
  cluster_name = "dev-ai-cluster"
  region       = "us-east-1"
  tags = {
    ManagedBy   = "DeepAgent"
    Cluster     = local.cluster_name
    Environment = "production"
    Team        = "devops"
  }
}

# Reusing existing VPC vpc-0458a23d9cb5dfece with the given subnets.
locals {
  vpc_id         = "vpc-0458a23d9cb5dfece"
  subnet_ids     = ["subnet-0589bda4e647c5268", "subnet-0935fed30dcb57731", "subnet-02782cd78b5c1ae81", "subnet-0d133374462a08f71", "subnet-0d1f45b13d2362e5e", "subnet-0bd4864cc4f039463"]
  node_subnet_ids = ["subnet-0589bda4e647c5268", "subnet-0935fed30dcb57731", "subnet-0d1f45b13d2362e5e"]
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = local.cluster_name
  cluster_version = "1.36"

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  # Control-plane logging → CloudWatch (api, audit, authenticator, controllerManager, scheduler).
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # Encrypt Kubernetes secrets at rest with a dedicated KMS key (module-managed).
  cluster_encryption_config = {
    resources = ["secrets"]
  }

  cluster_addons = {
    coredns    = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni    = { most_recent = true }
    aws-ebs-csi-driver = { most_recent = true }
  }

  vpc_id     = local.vpc_id
  subnet_ids = local.subnet_ids

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    system = {
      subnet_ids     = local.node_subnet_ids
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      disk_size      = 100
      labels = { role = "system" }
      taints = {
        CriticalAddonsOnly = { key = "CriticalAddonsOnly", value = "true", effect = "NO_SCHEDULE" }
      }
    }
    application = {
      subnet_ids     = local.node_subnet_ids
      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
      min_size       = 2
      max_size       = 20
      desired_size   = 3
      labels = { role = "application", env = "production" }
    }
  }

  tags = local.tags
}
