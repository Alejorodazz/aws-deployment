#Creación de VPC
resource "aws_vpc" "main" {
  cidr_block           = var.VPC_config.cidr_block
  enable_dns_support   = var.VPC_config.enable_dns_support 
  enable_dns_hostnames = var.VPC_config.enable_dns_hostnames

  tags = var.common_tags
}