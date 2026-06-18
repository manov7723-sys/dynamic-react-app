output "cluster_role_arn" {
  value = var.create_cluster_role ? one(aws_iam_role.cluster[*].arn) : var.existing_cluster_role_arn
}
output "node_role_arn" {
  value = var.create_node_role ? one(aws_iam_role.node[*].arn) : var.existing_node_role_arn
}
