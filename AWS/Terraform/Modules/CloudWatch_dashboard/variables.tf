variable "service_full_name" {
  description = "Full service name. prefix + environment"
}

variable "application_name" {
  description = "Name of the application"
}

variable "alb_arn_suffix" {
  description = "ARN sufix of the ALB to monitor"
}

variable "region" {
  description = "Region on wich is CloudWatch"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the ECS cluster to monitor"
} 