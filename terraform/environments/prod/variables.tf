variable "region" { type = string }
variable "cluster_name" { type = string }
variable "k8s_version" { type = string }
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "create_vpc" {
  type    = bool
  default = true
}
variable "subnet_count" {
  type    = number
  default = 2
}
variable "node_subnet_type" {
  type    = string
  default = "private"
}
variable "existing_subnet_ids" {
  type    = string
  default = ""
}
variable "existing_node_subnet_ids" {
  type    = string
  default = ""
}
variable "single_nat_gateway" {
  type    = bool
  default = true
}
variable "instance_type" { type = string }
variable "desired_size" { type = number }
variable "min_size" { type = number }
variable "max_size" { type = number }
variable "endpoint_public_access" {
  type    = bool
  default = true
}
variable "public_access_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "node_disk_size" {
  type    = number
  default = 50
}
variable "admin_principal_arns" {
  type    = list(string)
  default = []
}
variable "tags" {
  type    = map(string)
  default = {}
}
