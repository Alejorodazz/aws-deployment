output "server_demo_public-ip" {
    description = "IP pública de la instancia servidor demo"
    value = aws_instance.server_demo.public_ip
}

output "server_demo_type-instance" {
    description = "Tipo de instancia de mi EC2"
    value = aws_instance.server_demo.instance_type
}

output "VPC_main_block-CDIR" {
    description = "Descripción de bloque CDIR aplicadas a VPC"
    value = aws_vpc.main.cidr_block
}

