resource "aws_launch_configuration" "ecs-launch-configuration" {
  count                       = var.is_spot ? 0 : 1
  name_prefix                 = "${aws_ecs_cluster.application.name}-launch-"
  image_id                    = data.aws_ssm_parameter.aws_ecs_ami.value
  instance_type               = var.cluster_instance_type
  associate_public_ip_address = "false"
  iam_instance_profile        = aws_iam_instance_profile.ecs-instance-profile.id
  security_groups             = var.security_groups
  key_name                    = var.instance_ssh_key
  user_data                   = data.template_file.ecs_user_data.rendered

  root_block_device {
    volume_type           = "standard"
    volume_size           = var.root_volume_size
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [image_id]
  }
}

resource "aws_autoscaling_group" "ecs-autoscaling-group" {
  count                 = var.is_spot ? 0 : 1
  name                  = "${aws_ecs_cluster.application.name}-ecs-workers"
  max_size              = var.max_workers
  min_size              = var.initial_workers
  desired_capacity      = var.initial_workers
  protect_from_scale_in = true
  vpc_zone_identifier   = var.instance_subnets
  launch_configuration  = aws_launch_configuration.ecs-launch-configuration[0].name
  health_check_type     = "EC2"

  lifecycle {
    ignore_changes = [desired_capacity]
  }

  enabled_metrics = [
    "GroupStandbyInstances",
    "GroupTotalInstances",
    "GroupPendingInstances",
    "GroupTerminatingInstances",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupMinSize",
    "GroupMaxSize",
  ]

  tags = [
    {
      key                 = "Name"
      value               = "${aws_ecs_cluster.application.name}-worker"
      propagate_at_launch = true
    },
    {
      key                 = "Environment"
      value               = var.environment
      propagate_at_launch = true
    },
    {
      key                 = "Application"
      value               = "app-${var.environment}"
      propagate_at_launch = true
    },
    {
      key                 = "Monitoring"
      value               = "On"
      propagate_at_launch = true
    },
  ]
}
