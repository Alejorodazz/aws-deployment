module "server-web-testing" {
  source = "../../modules"

  ec2_config = var.ec2_config_test
  common_tags = var.common_tags_test
}