resource "aws_security_group" "server_demo" {
    name        = var.common_tags.name
    description = "Trafico para la aplicacion"
    vpc_id      = aws_vpc.main.id

   ingress {
    description = "Conexiones por SSH"
    from_port   = var.security_groups_config_ssh.from_port
    to_port     = var.security_groups_config_ssh.to_port
    protocol    = var.security_groups_config_ssh.protocol
    cidr_blocks = var.security_groups_config_ssh.cidr_blocks
  }

  ingress {
    description = "HTTP"
    from_port   = var.security_groups_config_HTTP.from_port
    to_port     = var.security_groups_config_HTTP.to_port
    protocol    = var.security_groups_config_HTTP.protocol
    cidr_blocks = var.security_groups_config_HTTP.cidr_blocks
  }

  ingress {
    description = "HTTPS"
    from_port   = var.security_groups_config_HTTPS.from_port
    to_port     = var.security_groups_config_HTTPS.to_port
    protocol    = var.security_groups_config_HTTPS.protocol
    cidr_blocks = var.security_groups_config_HTTPS.cidr_blocks
  }

  egress {
    from_port   = var.security_groups_config_egress.from_port
    to_port     = var.security_groups_config_egress.to_port
    protocol    = var.security_groups_config_egress.protocol
    cidr_blocks = var.security_groups_config_egress.cidr_blocks
  }

  tags = var.common_tags
  
}