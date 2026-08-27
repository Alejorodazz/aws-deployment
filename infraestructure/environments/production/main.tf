module "server-production" {
  source = "../../modules"
  instance_type = var.instance_type_production
  ami_id = var.ami_id_prod
}