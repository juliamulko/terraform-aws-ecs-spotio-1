variable "cluster_name" {
  type = string
}

variable "is_spot" {
  type    = bool
  default = true
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


# On Demand Only
variable "cluster_instance_type" {
  type    = string
  default = "m5.large"
}

variable "initial_workers" {
  type    = number
  default = 3
}

variable "max_workers" {
  type    = number
  default = 10
}
