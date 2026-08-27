module "server_web_testing" {
  source = "../../modules"

  ami_id = var.ami_id_test
  instance_type = var.instance_type_test
}