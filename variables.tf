variable "cluster_name" {
  type = string
}

variable "environment" {
  type        = string
  description = "This would help you distinguish between your different environments"
}

variable "instance_ssh_key" {
  type = string
}

variable "instance_subnets" {
  type = list(string)
}

variable "root_volume_size" {
  type    = number
  default = 100
}

variable "security_groups" {
  type    = list(string)
  default = []
}

variable "efs_security_group" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "spotinst_account" {
  type    = string
}

variable "spotinst_token" {
  type    = string
}
