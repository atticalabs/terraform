variable "server_name" {
  description = "SQL Server name"
  default     = "core-sql-server"
}

variable "database_name" {
  description = "SQL Database name"
  default     = "core-db"
}

variable "workload" {
  description = "SQL Database Performance Workload Level in Azure (Basic, Standard or Production)"
  default     = "Basic"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
}

variable "resource_group_name" {
  description = "App service name"
}