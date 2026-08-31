resource "aws_instance" "server_demo" {
      # Configuraciones iniciales
      ami = var.ec2_config.ami_id
      instance_type = var.ec2_config.instance_type
      
      # Configuraciones de red
      subnet_id = aws_subnet.public.id
      vpc_security_group_ids = [ aws_security_group.server_demo.id ]
      associate_public_ip_address = true
      key_name = aws_key_pair.server_demo_ssh.key_name

      # Bootstrap completo de la instancia
      user_data_base64 = data.cloudinit_config.servidor_config.rendered

    tags = var.common_tags
}
