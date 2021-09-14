# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# AZURE SERVICE PRINCIPAL CREDENTIALS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
variable "subscription_id" {
  description = "Azure Service Principal Suscription ID"
}

variable "client_id" {
  description = "Azure Service Principal Client ID"
}

variable "client_secret" {
  description = "Azure Service Principal Client Secret"
}

variable "tenant" {
  description = "Azure Subscription Tenant ID"
}

variable "prefix" {
  description = "The prefix used for all resources in this example"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# APP SERVICE CONFIGURATION
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
variable "core_api_cors_allowed_origins" {
  description = "Allowed origins for Core Api"
  default     = []
}

variable "aspnet_environment" {
  description = "ASPNET Environment variable"
  default     = "Testing"
}

variable "app_service_tier" {
  description = "App service instance tier. Ex. Basic, Standard"
  default     = "Shared"
}

variable "app_service_tier_size" {
  description = "App service instance tier size. Ex. F1, B1, B2, S1, S2"
  default     = "F1"
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# SQL SERVER CONFIGURATION
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
variable "sql_server_name" {
  description = "SQL Server name"
  default     = "attica-sql-server"
}

variable "main_sql_database" {
  description = "SQL Database name"
  default     = "attica"
}
