resource "aws_security_group" "alb" {
  name        = "${var.infrastructure_config.name_prefix}-alb"
  description = "Controla el trafico entrante hacia el balanceador de carga."
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.infrastructure_config.alb.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    description = "Trafico hacia las instancias de aplicacion"
    from_port   = var.infrastructure_config.compute.app_port
    to_port     = var.infrastructure_config.compute.app_port
    protocol    = var.infrastructure_config.compute.app_protocol
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = merge(var.infrastructure_config.tags, { Name = "${var.infrastructure_config.name_prefix}-alb-sg" })
}

resource "aws_security_group" "app" {
  name        = "${var.infrastructure_config.name_prefix}-app"
  description = "Permite trafico de aplicacion unicamente desde el balanceador de carga."
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Trafico desde el balanceador de carga de la aplicacion"
    from_port       = var.infrastructure_config.compute.app_port
    to_port         = var.infrastructure_config.compute.app_port
    protocol        = var.infrastructure_config.compute.app_protocol
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Trafico saliente"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.infrastructure_config.network.internet_route_cidr]
  }

  tags = merge(var.infrastructure_config.tags, { Name = "${var.infrastructure_config.name_prefix}-app-sg" })
}

resource "aws_security_group" "database" {
  name        = "${var.infrastructure_config.name_prefix}-database"
  description = "Permite trafico MySQL unicamente desde la capa de aplicacion."
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "MySQL desde la capa de aplicacion"
    from_port       = var.infrastructure_config.rds.port
    to_port         = var.infrastructure_config.rds.port
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    description = "Sin trafico saliente"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = []
  }

  tags = merge(var.infrastructure_config.tags, { Name = "${var.infrastructure_config.name_prefix}-database-sg" })
}
