variable "ec2_config_prod" {
  type = object({
    ami_id = string
    instance_type = string
    volume_size = number
    volume_type = string
  })
}

variable "common_tags_prod" {
   type = map(string)
}

/*
variable "availability_zones" {
  description = "Zonas de dispocisión dentro de la región US-EAST-1"
  type = list(string)
}
*/

variable "VPC_config" {
  type = object({
    cidr_block           = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
  })
  
}
variable "subnet_publics_config_prod" {
  type = object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = bool
  })
  
}

variable "security_groups_config_ssh" {
  type = object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })
}

variable "security_groups_config_HTTP" {
  type = object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })
}

variable "security_groups_config_HTTPS" {
  type = object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })
}

variable "security_groups_config_egress" {
  type = object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  })
}