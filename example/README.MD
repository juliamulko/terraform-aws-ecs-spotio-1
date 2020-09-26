# Module Usage example

This example shows how to utilize the module using spot.io instances.
You must create a spot.io account and provide the account id and token to this module.

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which can cost money (AWS EC2 instances, for example). Run `terraform destroy` when you don't need these resources.

## Explanation

Current version creates an high-available VPC with instances that are attached to ECS. ECS tasks can be run on these instances but they are not exposed to anything (e.g - No load balancer)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| spotinst\_account | The account id for spot.io | `string` | n/a | yes |
| spotinst\_token | The account token for spot.io | `string` | n/a | yes |


## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->