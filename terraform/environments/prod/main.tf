module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"
  cluster_name = "my-eks-cluster-eks"
  cluster_version = "1.30"
  enable_cluster_creator_admin_permissions = true
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}
