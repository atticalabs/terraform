output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "security_group_ids" {
  value = module.networking.security_group_ids
}

output "cloudwatch_log_group" {
  value = module.cloudwatch.log_group
}

output "ecs_inbound_sg" {
  value = module.ecs_cluster.inbound_sg
}

output "cluster_id" {
  value = module.ecs_cluster.cluster_id
}

output "cluster_name" {
  value = module.ecs_cluster.cluster_name
}

output "log_group" {
  value = module.cloudwatch.log_group
}