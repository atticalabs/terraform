variable "service_full_name" {
  description = "Full name of the service"
}

variable "vpc_id" {
  description = "Id of the VPC (Virtual Private Cloud) on wich the ALB (Load balancer) will be created"
}

variable "subnet_ids" {
  description = "List of ids of the SubNets on wich the ALB (Load balancer) will be created"
}

variable "security_group_ids" {
  description = "List of ids of the Security Groups wich the ALB (Load balancer) will have"
}

variable "ecs_inbound_sg" {
  description = "Id of the Security Group of the ECS."
}

variable "environment" {
  description = "Enviroment name"
}

variable "load_balancer_protcol" {

}

variable "target_group_registration_port" {

}

variable "target_group_registration_potocol" {

}

variable "certificate_arn" {

}