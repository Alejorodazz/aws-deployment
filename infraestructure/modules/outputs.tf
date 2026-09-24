output "load_balancer_dns_name" {
  description = "Nombre DNS público del balanceador de carga de la aplicación."
  value       = aws_lb.app.dns_name
}

output "ecr_repository_url" {
  description = "URL del repositorio utilizado por las imágenes de la aplicación."
  value       = aws_ecr_repository.app.repository_url
}

output "rds_endpoint" {
  description = "Endpoint privado de la base de datos MySQL."
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}

output "vpc_id" {
  description = "ID de la VPC creada para este ambiente."
  value       = aws_vpc.main.id
}
