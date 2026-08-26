provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

#Creación de VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "devops-lab-vpc"
  }
}

# Creación de subred pública enlazado a VPC por su ID
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "devops-lab-public-subnet"
  }
}

# Recurso de internet gateway permitiendo a mi VPC main comunicarse con internet
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "devops-lab-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "devops-lab-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}


# Creación de instancias con distribución Ubuntu 
resource "aws_instance" "server_demo" {
      ami = "ami-052355af2a014bd2c"
      instance_type = "t3.medium"
      subnet_id = aws_subnet.public.id
      vpc_security_group_ids = [ aws_security_group.server_demo.id ]
      associate_public_ip_address = true
      key_name = aws_key_pair.server_demo_ssh.key_name

      # Implementación de bash scripting
      user_data = file("../scripts/03_nginx_install.sh")

    tags = {
      name = "devops_lab"
      environment = "test"
      team = "Devops"
      project = "aws-deployment"
    }
}

# Creación de mi clave ssh para conexión de mi IP pública a mi instancia EC2 
resource "aws_key_pair" "server_demo_ssh" {
    key_name = "server_demo_ssh"
    public_key = file("../server_demo.key.pub ")
}

# Security Groups
resource "aws_security_group" "server_demo" {
    name        = "devops-lab-app-sg"
    description = "Trafico para la aplicacion"
    vpc_id      = aws_vpc.main.id

   ingress {
    description = "Conexiones por SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-lab-app-sg"
  }
}