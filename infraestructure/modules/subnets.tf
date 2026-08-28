resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_publics_config.cidr_block
  availability_zone       = var.subnet_publics_config.availability_zone
  map_public_ip_on_launch = var.subnet_publics_config.map_public_ip_on_launch 

  tags = var.common_tags
}

