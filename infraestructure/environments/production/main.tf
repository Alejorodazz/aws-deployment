module "infrastructure" {
  source = "../../modules"

  aws_region            = var.aws_region
  infrastructure_config = var.infrastructure_config
  rds_password          = var.rds_password
}
