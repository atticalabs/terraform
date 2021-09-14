output "database_host" {
  value = aws_rds_cluster.default.endpoint
}

output "database_name" {
  value = var.cluster_database_name
}

output "database_username" {
  value = var.cluster_username
}

output "database_password" {
  value = var.cluster_password
}

output "database_instance_id" {
  value = aws_rds_cluster.default.cluster_identifier
}
