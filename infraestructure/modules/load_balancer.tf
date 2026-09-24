resource "aws_lb" "app" {
  name                       = var.infrastructure_config.alb.name
  internal                   = var.infrastructure_config.alb.internal
  load_balancer_type         = var.infrastructure_config.alb.load_balancer_type
  security_groups            = [aws_security_group.alb.id]
  subnets                    = values(aws_subnet.public)[*].id
  ip_address_type            = var.infrastructure_config.alb.ip_address_type
  idle_timeout               = var.infrastructure_config.alb.idle_timeout
  enable_deletion_protection = var.infrastructure_config.alb.enable_deletion_protection

  tags = merge(var.infrastructure_config.tags, { Name = var.infrastructure_config.alb.name })
}

resource "aws_lb_target_group" "app" {
  name        = var.infrastructure_config.alb.target_group_name
  port        = var.infrastructure_config.alb.target_port
  protocol    = var.infrastructure_config.alb.target_protocol
  target_type = var.infrastructure_config.alb.target_type
  vpc_id      = aws_vpc.main.id

  health_check {
    path                = var.infrastructure_config.alb.health_check_path
    matcher             = var.infrastructure_config.alb.health_check_matcher
    interval            = var.infrastructure_config.alb.health_check_interval
    timeout             = var.infrastructure_config.alb.health_check_timeout
    healthy_threshold   = var.infrastructure_config.alb.healthy_threshold
    unhealthy_threshold = var.infrastructure_config.alb.unhealthy_threshold
  }

  tags = merge(var.infrastructure_config.tags, { Name = var.infrastructure_config.alb.target_group_name })
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = var.infrastructure_config.alb.listener_port
  protocol          = var.infrastructure_config.alb.listener_protocol
  certificate_arn   = var.infrastructure_config.alb.listener_certificate_arn
  ssl_policy        = var.infrastructure_config.alb.listener_ssl_policy

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
