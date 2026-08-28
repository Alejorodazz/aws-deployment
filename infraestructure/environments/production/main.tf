module "server-production" {
  source = "../../modules"
 
 ec2_config = var.ec2_config_prod
}