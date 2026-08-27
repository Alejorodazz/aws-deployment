resource "aws_instance" "server_demo" {
      ami = var.ami_id
      instance_type = var.instance_type
      subnet_id = aws_subnet.public.id
      vpc_security_group_ids = [ aws_security_group.server_demo.id ]
      associate_public_ip_address = true
      key_name = aws_key_pair.server_demo_ssh.key_name

      # Bootstrap completo de la instancia
      user_data = file("${path.module}/../../scripts/bootstrap.sh")

    tags = {
      name = var.name_tag
      environment = var.environment_tag
      owner = var.owner_tag
      team = var.team_tag
      project = var.project_tag
    }
}
