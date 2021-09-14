variable "account_name" {
  description = "CosmosDB account name"  
}

variable "db_name" {
  description = "CosmosDB name"  
}

variable "privisioned_throughput" {
  description = "Amount of RU(s) to be provisioned for this db (defaults to 400, which is the minimum)"
  default     = 400
}

variable "resource_group_name" {
  description = "resource group"
}

variable "location" {
  description = "Account location"
}