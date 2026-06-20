variable "name" { type = string }
variable "create_cluster_role" {
  type    = bool
  default = true
}
variable "existing_cluster_role_arn" {
  type    = string
  default = ""
}
variable "create_node_role" {
  type    = bool
  default = true
}
variable "existing_node_role_arn" {
  type    = string
  default = ""
}
variable "tags" {
  type    = map(string)
  default = {}
}
