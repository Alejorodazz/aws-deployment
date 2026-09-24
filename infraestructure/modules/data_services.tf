resource "aws_db_subnet_group" "main" {
  name       = "${var.infrastructure_config.name_prefix}-db-subnets"
  subnet_ids = values(aws_subnet.private_data)[*].id

  tags = merge(var.infrastructure_config.tags, { Name = "${var.infrastructure_config.name_prefix}-db-subnets" })
}

resource "aws_db_instance" "main" {
  identifier              = var.infrastructure_config.rds.identifier
  engine                  = var.infrastructure_config.rds.engine
  engine_version          = var.infrastructure_config.rds.engine_version
  instance_class          = var.infrastructure_config.rds.instance_class
  allocated_storage       = var.infrastructure_config.rds.allocated_storage
  max_allocated_storage   = var.infrastructure_config.rds.max_allocated_storage
  storage_type            = var.infrastructure_config.rds.storage_type
  storage_encrypted       = var.infrastructure_config.rds.storage_encrypted
  db_name                 = var.infrastructure_config.rds.db_name
  username                = var.infrastructure_config.rds.username
  password                = var.rds_password
  port                    = var.infrastructure_config.rds.port
  multi_az                = var.infrastructure_config.rds.multi_az
  publicly_accessible     = var.infrastructure_config.rds.publicly_accessible
  backup_retention_period = var.infrastructure_config.rds.backup_retention_period
  backup_window           = var.infrastructure_config.rds.backup_window
  maintenance_window      = var.infrastructure_config.rds.maintenance_window
  skip_final_snapshot     = var.infrastructure_config.rds.skip_final_snapshot
  deletion_protection     = var.infrastructure_config.rds.deletion_protection
  apply_immediately       = var.infrastructure_config.rds.apply_immediately
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.database.id]

  tags = merge(var.infrastructure_config.tags, { Name = var.infrastructure_config.rds.identifier })
}
