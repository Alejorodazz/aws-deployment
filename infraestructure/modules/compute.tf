resource "aws_launch_template" "server_demo" {
  name                   = var.infrastructure_config.compute.launch_template_name
  image_id               = var.infrastructure_config.compute.ami_id
  instance_type          = var.infrastructure_config.compute.instance_type
  key_name               = var.infrastructure_config.compute.key_name
  ebs_optimized          = var.infrastructure_config.compute.ebs_optimized
  update_default_version = true

  monitoring {
    enabled = var.infrastructure_config.compute.monitoring_enabled
  }

  network_interfaces {
    associate_public_ip_address = var.infrastructure_config.compute.associate_public_ip
    security_groups             = [aws_security_group.app.id]
  }

  block_device_mappings {
    device_name = var.infrastructure_config.compute.volume_device_name

    ebs {
      delete_on_termination = var.infrastructure_config.compute.volume_delete_on_terminate
      encrypted             = var.infrastructure_config.compute.volume_encrypted
      volume_size           = var.infrastructure_config.compute.volume_size
      volume_type           = var.infrastructure_config.compute.volume_type
    }
  }

  user_data = data.cloudinit_config.server_demo.rendered

  tag_specifications {
    resource_type = "instance"
    tags          = merge(var.infrastructure_config.tags, { Name = "${var.infrastructure_config.name_prefix}-app" })
  }

}

resource "aws_autoscaling_group" "server_demo" {
  name                      = var.infrastructure_config.compute.asg_name
  min_size                  = var.infrastructure_config.compute.min_size
  max_size                  = var.infrastructure_config.compute.max_size
  desired_capacity          = var.infrastructure_config.compute.desired_capacity
  health_check_type         = var.infrastructure_config.compute.health_check_type
  health_check_grace_period = var.infrastructure_config.compute.health_check_grace_period
  vpc_zone_identifier       = values(aws_subnet.private_app)[*].id
  target_group_arns         = [aws_lb_target_group.app.arn]

  launch_template {
    id      = aws_launch_template.server_demo.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.infrastructure_config.name_prefix}-app"
    propagate_at_launch = true
  }
}
