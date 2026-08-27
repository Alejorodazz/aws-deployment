variable "ami_id_prod" {
    description = "ami utilizada en producción"
    default = "ami-052355af2a014bd2c"
}

variable "instance_type_production" {
    description = "Tamaño de instancia para producción"
    default = "t4.medium"
}