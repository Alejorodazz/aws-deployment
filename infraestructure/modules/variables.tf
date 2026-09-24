variable "aws_region" {
  description = "Región de AWS donde se despliega la infraestructura."
  type        = string
}

variable "infrastructure_config" {
  description = "Configuración completa de la infraestructura específica por ambiente."

  type = object({
    name_prefix = string
    tags        = map(string)

    vpc = object({
      cidr_block           = string
      enable_dns_support   = bool
      enable_dns_hostnames = bool
    })

    public_subnets = map(object({
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))

    private_app_subnets = map(object({
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))

    private_data_subnets = map(object({
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))

    network = object({
      internet_route_cidr    = string
      nat_gateway_subnet_key = string
      nat_allocation_domain  = string
    })

    alb = object({
      name                       = string
      internal                   = bool
      load_balancer_type         = string
      ip_address_type            = string
      idle_timeout               = number
      enable_deletion_protection = bool
      listener_port              = number
      listener_protocol          = string
      listener_certificate_arn   = string
      listener_ssl_policy        = string
      target_group_name          = string
      target_port                = number
      target_protocol            = string
      target_type                = string
      health_check_path          = string
      health_check_matcher       = string
      health_check_interval      = number
      health_check_timeout       = number
      healthy_threshold          = number
      unhealthy_threshold        = number
      ingress_rules = list(object({
        description = string
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
      }))
    })

    compute = object({
      launch_template_name       = string
      ami_id                     = string
      instance_type              = string
      key_name                   = string
      associate_public_ip        = bool
      monitoring_enabled         = bool
      ebs_optimized              = bool
      volume_device_name         = string
      volume_size                = number
      volume_type                = string
      volume_delete_on_terminate = bool
      volume_encrypted           = bool
      asg_name                   = string
      min_size                   = number
      max_size                   = number
      desired_capacity           = number
      health_check_type          = string
      health_check_grace_period  = number
      app_port                   = number
      app_protocol               = string
    })

    rds = object({
      identifier              = string
      engine                  = string
      engine_version          = string
      instance_class          = string
      allocated_storage       = number
      max_allocated_storage   = number
      storage_type            = string
      storage_encrypted       = bool
      db_name                 = string
      username                = string
      port                    = number
      multi_az                = bool
      publicly_accessible     = bool
      backup_retention_period = number
      backup_window           = string
      maintenance_window      = string
      skip_final_snapshot     = bool
      deletion_protection     = bool
      apply_immediately       = bool
    })

    ecr = object({
      repository_name      = string
      image_tag_mutability = string
      scan_on_push         = bool
      force_delete         = bool
    })

    cloudflare = object({
      enabled     = bool
      zone_id     = string
      record_name = string
      proxied     = bool
      ttl         = number
    })
  })
}

variable "rds_password" {
  description = "Contraseña maestra de RDS. Debe suministrarse desde una fuente segura de variables."
  type        = string
  sensitive   = true
}
