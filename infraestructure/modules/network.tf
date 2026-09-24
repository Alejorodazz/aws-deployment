resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.infrastructure_config.tags, { Name = "${var.infrastructure_config.name_prefix}-igw" })
}

resource "aws_eip" "nat" {
  domain = var.infrastructure_config.network.nat_allocation_domain
  tags   = merge(var.infrastructure_config.tags, { Name = "${var.infrastructure_config.name_prefix}-nat-eip" })
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[var.infrastructure_config.network.nat_gateway_subnet_key].id

  tags       = merge(var.infrastructure_config.tags, { Name = "${var.infrastructure_config.name_prefix}-nat" })
  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.infrastructure_config.network.internet_route_cidr
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(var.infrastructure_config.tags, { Name = "${var.infrastructure_config.name_prefix}-public-rt" })
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = var.infrastructure_config.network.internet_route_cidr
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = merge(var.infrastructure_config.tags, { Name = "${var.infrastructure_config.name_prefix}-private-rt" })
}

resource "aws_route_table_association" "private_app" {
  for_each = aws_subnet.private_app

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_data" {
  for_each = aws_subnet.private_data

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
