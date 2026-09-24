resource "aws_vpc" "main" {
  cidr_block           = var.infrastructure_config.vpc.cidr_block
  enable_dns_support   = var.infrastructure_config.vpc.enable_dns_support
  enable_dns_hostnames = var.infrastructure_config.vpc.enable_dns_hostnames

  tags = merge(var.infrastructure_config.tags, {
    Name = "${var.infrastructure_config.name_prefix}-vpc"
  })
}
