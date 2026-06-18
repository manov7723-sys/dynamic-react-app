variable "name" { type = string }
variable "k8s_version" { type = string }
variable "cluster_role_arn" { type = string }
variable "node_role_arn" { type = string }
variable "subnet_ids" { type = list(string) }
variable "node_subnet_ids" { type = list(string) }
variable "instance_type" {
  type    = string
  default = "t3.medium"
}
variable "desired_size" {
  type    = number
  default = 2
}
variable "min_size" {
  type    = number
  default = 1
}
variable "max_size" {
  type    = number
  default = 3
}
variable "endpoint_mode" {
  type    = string
  default = "public_and_private"
}
variable "public_access_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "enabled_addons" {
  type    = list(string)
  default = ["vpc-cni", "coredns", "kube-proxy", "aws-ebs-csi-driver"]
}
variable "node_disk_size" {
  type    = number
  default = 50
}
variable "log_retention_days" {
  type    = number
  default = 90
}
variable "admin_principal_arns" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}
