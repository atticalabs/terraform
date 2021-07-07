output "cluster_name" {
  value = aws_ecs_cluster.cluster.name
}

output "cluster_id" {
  value = aws_ecs_cluster.cluster.id
}

output "inbound_sg" {
  value = aws_security_group.inbound_sg.id
}

