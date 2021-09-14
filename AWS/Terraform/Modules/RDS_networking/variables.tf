
variable "cidr_for_public_access" {
  default = ["0.0.0.0/0"]
}

variable "environment" {
  description = "The environment"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "env_full_name" {
  description = "Envirnoment name"
}

variable "subnet_ids" {
  description = "Subnets"
}