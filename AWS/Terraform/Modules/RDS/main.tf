/*====
RDS
======*/


resource "aws_db_instance" "rds" {
  identifier              = var.identifier
  allocated_storage       = var.allocated_storage
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  multi_az                = var.multi_az
  name                    = var.database_name
  username                = var.database_username
  password                = var.database_password
  db_subnet_group_name    = var.subnet_group_id
  vpc_security_group_ids  = [var.security_group_ids]
  skip_final_snapshot     = true
  backup_retention_period = 7
  backup_window           = "02:00-06:00"
  publicly_accessible     = var.publicly_accessible
  deletion_protection     = var.deletion_protection
  apply_immediately       = var.apply_immediately
  storage_encrypted       = var.storage_encrypted
  monitoring_interval     = var.monitoring_interval

  tags = {
    Environment = var.environment
  }
}

