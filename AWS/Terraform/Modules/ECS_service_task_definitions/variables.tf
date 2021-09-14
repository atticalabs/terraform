variable "cluster_id" {
  description = "Id of the cluster where the service is created."
}

variable "cluster_name" {
  description = "Name of the cluster where the service is created."
}

variable "container_definitions" {
  description = "Definition of the containers that should be in the task definition."
}

variable "task_definition_network_mode" {
  description = "Network mode for the task definition."
}

variable "task_definition_role_arn" {
  description = "The ARN of the role used in the task definition."
}

variable "system_name" {
  description = "Name of the system where the task is created."
}

variable "env_name" {
  description = "Name of the environment where the task is created."
}

variable "service_tasks_count" {
  description = "Number of tasks the service can have."
}

variable "service_launch_type" {
  description = "Service lauch type."
}

variable "load_balancer_target_group_arn" {
  description = "ARN of the service load balancer."
}

variable "load_balancer_container_name" {
  description = "Name of the container fowarded by the load balancer."
}

variable "load_balancer_container_port" {
  description = "Port of the container fowarded by the load balancer."
}

variable "service_full_name" {

}