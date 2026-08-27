variable "ami_id_test" {
  description = "Imagen para instancias en entorno de testing"
  default = "ami-052355af2a014bd2c"

}

variable "instance_type_test" {
  description = "Tipo de instancia para entorno testing"
  default = "t3.medium"
}