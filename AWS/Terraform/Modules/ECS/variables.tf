variable "env_full_name" {
  description = "Full environment name. prefix + environment"
}

variable "ecs_min_size" {
  description = "Minimum capacity of EC2 instantes"
  default     = 1
}

variable "ecs_desired_capacity" {
  description = "Desired capacity of EC2 instantes"
  default     = 2
}

variable "ecs_max_size" {
  description = "Maximum capacity of EC2 instantes"
  default     = 4
}

variable "ssh_key_file" {
  description = "RSA key to access"
}

variable "environment" {
  description = "The environment"
}

variable "log_group" {
  description = "Cloudwatch log group"
}

variable "image_id" {
}

variable "vpc_id" {
}

variable "instance_type" {
}

variable "security_group_ids" {
  type        = list(string)
  description = "The SGs to use"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The private subnets to use"
}
