output "cluster_name" {
  value = module.eks.cluster_name
}
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
output "vpc_id" {
  value = var.create_vpc ? one(module.vpc[*].vpc_id) : "existing-vpc"
}
output "region" {
  value = var.region
}
output "kubeconfig_command" {
  value = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.region}"
}
