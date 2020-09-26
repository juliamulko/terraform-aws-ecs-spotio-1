provider "aws" {
  region = "us-east-1" // Change to your prefered region
}

provider "spotinst" {
  account = var.spotinst_account
  token   = var.spotinst_token
}

locals {
  environment = "dev" // Change to your environment
  tags = {
    "Environment" = local.environment
    "Application" = "example-app-${local.environment}" // Change to your app name
  }
}

module "ecs-cluster-spot" {
  source           = "../"
  cluster_name     = "${local.environment}-ecs"
  environment      = local.environment
  tags             = local.tags
  instance_subnets = module.vpc.private_subnets
  instance_ssh_key = "${local.environment}-app-key" // Your instance key name here
  security_groups  = "${concat(list("${aws_security_group.ecs_app.id}"), "${var.app_cluster_extra_sg}")}"
  providers = {
    aws                   = aws
    spotinst.spot_account = spotinst
  }
}
