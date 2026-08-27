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

variable "ami_id" {
  description = "Bloque de CIDR por defecto a VPCs"
  default = "ami-052355af2a014bd2c"
}

variable "instance_type" {
  description = "Tipo de instancia"
  default = "t3.medium"
}

## tags para instancias ec2 -------------

variable "name_tag" {
  description = "Etiqueta de nombre para instancias ec2"
  default = "devops_lab"
}

variable "environment_tag" {
  description = "Etiqueta de entorno para instancias ec2"
  default = "test"
}

variable "owner_tag" {
  description = "Etiqueta de dueño para instancias ec2"
  default = "alejandrorodas003@gmail"
}

variable "team_tag" {
  description = "Etiqueta de equipo para instancias ec2"
  default = "Devops Team"
}

variable "project_tag" {
  description = "Etiqueta de proyecto para instancias ec2"
  default = "aws-deployment"
}

## ------------------------------------------------------

# --------------------------------------------------

# variables para VPC -------------------------



## tags para VPS ---------------------------
## -------------------------------------------

# -------------------------------------------------
