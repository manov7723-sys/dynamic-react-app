variable "name" { type = string }
variable "k8s_version" { type = string }
variable "cluster_role_arn" { type = string }
variable "node_role_arn" { type = string }
variable "subnet_ids" { type = list(string) }
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
variable "endpoint_public_access" {
  type    = bool
  default = true
}
variable "admin_principal_arns" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}
