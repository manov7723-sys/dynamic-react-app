output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = module.eks.cluster_endpoint
}

output "vpc_id" {
  description = "VPC the cluster runs in"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private subnet IDs used by the node group"
  value       = module.vpc.private_subnets
}

output "cluster_role_arn" {
  description = "IAM role ARN for the EKS control plane"
  value       = module.iam.cluster_role_arn
}

output "node_role_arn" {
  description = "IAM role ARN for the worker nodes"
  value       = module.iam.node_role_arn
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "kubeconfig_command" {
  description = "Run this to configure kubectl for the cluster"
  value       = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.region}"
}
