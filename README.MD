# AWS Elastic Container Service (ECS) + Spot.io Terraform module

This module will create an ECS cluter. By default, it will create a cluster with spot.io workers,
but you can use it to create a cluster with a regular aws scaling group as well (see inputs below).
For spot.io, the cluster size would be dynamically determined by number of services.


The resources create with this cluter
* [ECS](https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html)
* [IAM](https://www.terraform.io/docs/providers/aws/r/iam_instance_profile.html)
* [ASG](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html) OR --> [SPOT.IO Ocean](https://help.spot.io/ocean/ocean-overview-ecs/)


Please note, that you must have a vpc in tact, a security group is not mandatory, but your workers wouldn't be able to communicate. See the example for real life scenario usage.

## Terraform versions

This supports terraform 0.12 at the moment.

## Usage

* [Example](example)

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.7, < 0.13 |
| aws | >= 2.7, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.68, < 4.0 |
| spotinst | = 1.25.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | The name of the cluster, being used in other indetifiers as well | `string` | n/a | yes |
| is_spot | Should the cluster be spot.io based? | `bool` | `true` | yes |
| environment | The environment you are creating on (e.g - dev/staging/prod) | `string` | n/a | yes |
| region | The region of the resources | `string` | n/a | yes |
| instance_ssh_key | The ssh key name to attach to the workers (not the actual key, but the key name in aws) | `string` | n/a | yes |
| instance_subnets | List of subnets to spread the cluster workers on | `list(string)` | n/a | yes |
| root_volume_size | Workers volume size | `number` | 100 | yes |
| security_groups | List of security groups to attach to the workers | `list(string)` | [] | no |
| efs_security_group | Should you want to work with efs, provide the security group | `string` | "" | no |
| tags | A map of tags to add to ECS Cluster | `map(string)` | `{}` | no |
| cluster_instance_type | The instance type (For non spot cluster only) | `string` | `m5.large` | yes |
| initial_workers | Initial workers on cluster (For non spot cluster only) | `number` | `3` | yes |
| max_workers | Maximum workers on cluster (For non spot cluster only) | `number` | `10` | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | The aws id of the cluster |
| cluster\_name |  The name of the cluster |


## Authors

Module managed by [Yoad Fekete](https://github.com/yoadfe), contributors are welcome :)

## License

Apache 2 Licensed. See LICENSE for full details.
