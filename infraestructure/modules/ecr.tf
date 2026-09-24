resource "aws_ecr_repository" "app" {
  name                 = var.infrastructure_config.ecr.repository_name
  image_tag_mutability = var.infrastructure_config.ecr.image_tag_mutability
  force_delete         = var.infrastructure_config.ecr.force_delete

  image_scanning_configuration {
    scan_on_push = var.infrastructure_config.ecr.scan_on_push
  }

  tags = merge(var.infrastructure_config.tags, { Name = var.infrastructure_config.ecr.repository_name })
}
