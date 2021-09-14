variable "container_name" {
  description = "Name for the container"  
}

variable "db_account_name" {
  description = "CosmosDB account name"  
}

variable "db_name" {
  description = "CosmosDB name"  
}

variable "pkey_path" {
  description = "Path to partition key"
  default     = "/pkey"
}

variable "resource_group_name" {
  description = "resource group"
}