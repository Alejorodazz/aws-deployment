variable "aws_region" {
  description = "Región de AWS para el ambiente de pruebas."
  type        = string
}

variable "infrastructure_config" {
  description = "Configuración de infraestructura para el ambiente de pruebas."
  type        = any
}

variable "rds_password" {
  description = "Contraseña maestra sensible de RDS para pruebas."
  type        = string
  sensitive   = true
}
