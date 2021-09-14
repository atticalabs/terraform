# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# AZURE SERVICE PRINCIPAL CREDENTIALS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


variable "subscription_id" {
  description = "Azure Service Principal Suscription ID"
}

variable "tenant" {
  description = "Azure Subscription Tenant ID"
}

variable "client_id" {
  description = "Azure Service Principal Client ID"
}

variable "client_secret" {
  description = "Azure Service Principal Client Secret"
}
