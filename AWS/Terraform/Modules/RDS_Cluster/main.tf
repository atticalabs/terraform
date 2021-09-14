resource "aws_rds_cluster_instance" "cluster_instances" {
  count = var.cluster_instance_count

  identifier           = "${var.env_full_name}-cluster-instance-${count.index}"
  cluster_identifier   = aws_rds_cluster.default.id
  instance_class       = var.cluster_instance_type
  engine               = aws_rds_cluster.default.engine
  engine_version       = aws_rds_cluster.default.engine_version
  db_subnet_group_name = aws_rds_cluster.default.db_subnet_group_name
  publicly_accessible  = var.publicly_accessible
}

resource "aws_rds_cluster" "default" {
  cluster_identifier = "${var.env_full_name}-cluster"

  availability_zones     = var.cluster_availability_zones
  database_name          = var.cluster_database_name
  master_username        = var.cluster_username
  master_password        = var.cluster_password
  engine                 = var.cluster_engine
  db_subnet_group_name   = var.cluster_subnet_group_name
  vpc_security_group_ids = [var.cluster_security_group_ids]
  apply_immediately      = var.apply_immediately
  skip_final_snapshot    = true

  backup_retention_period = 5

  tags = {
    Environment = var.environment
  }
}