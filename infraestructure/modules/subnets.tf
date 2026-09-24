resource "aws_subnet" "public" {
  for_each = var.infrastructure_config.public_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge(var.infrastructure_config.tags, { Name = "${var.infrastructure_config.name_prefix}-public-${each.key}", Tier = "public" })
}

resource "aws_subnet" "private_app" {
  for_each = var.infrastructure_config.private_app_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge(var.infrastructure_config.tags, { Name = "${var.infrastructure_config.name_prefix}-app-${each.key}", Tier = "application" })
}

resource "aws_subnet" "private_data" {
  for_each = var.infrastructure_config.private_data_subnets

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge(var.infrastructure_config.tags, { Name = "${var.infrastructure_config.name_prefix}-data-${each.key}", Tier = "data" })
}
