variable "aws_region" {
  description = "Region de AWS para deploys"
  type        = string
  default     = "us-east-1"
}

# Variables de usuario IAM --------------
variable "aws_access_key_id" {
  description = "IAM access key ID. AWS_ACCESS_KEY_ID"
  type        = string
  sensitive   = true
  default     = null
}

variable "aws_secret_access_key" {
  description = "IAM secret access key. AWS_SECRET_ACCESS_KEY"
  type        = string
  sensitive   = true
  default     = null
}

# ------------------------------------------------

# variables para instancias ec2 ---------------------

variable "ec2_config" {
  type = object({
    ami_id = string
    instance_type = string

    #configuracion de almacenamiento de instancias
    volume_size = number
    volume_type = string
  })

}

## tags para instancias ec2 -------------

variable "common_tags" {
  type = map(string)

  default = {
    "name" = "devops_lab"
    "environment" = "test"
    "owner" = "alejandrorodas003@gmail.com"
    "team" = "Devops team"
    "project" = "aws-deployment"
  }
}


## ------------------------------------------------------

# --------------------------------------------------

# variables para VPC -------------------------
variable "VPC_config" {
  type = object({
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
  })

  default = {
    cidr_block           = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true
  }
  
}

variable "subnet_publics_config" {
  type = object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
  })

  default= {
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-east-1a"
    map_public_ip_on_launch = true
 }
  
}
# -------------------------------------------------
# Security Groups ---------------------------------

variable "security_groups_config_ssh" {
  type = object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })

  default = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "security_groups_config_HTTP" {
  type = object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })

  default = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "security_groups_config_HTTPS" {
  type = object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })

  default = {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "security_groups_config_egress" {
  type = object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })

  default = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# -------------------------------------------------
