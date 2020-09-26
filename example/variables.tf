variable "app_cluster_extra_sg" {
  type    = list(string)
  default = []
}

variable "spotinst_account" {
  type    = string
}

variable "spotinst_token" {
  type    = string
}
