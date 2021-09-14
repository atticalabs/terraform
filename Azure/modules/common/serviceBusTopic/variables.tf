# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Aure Service Bus Topic definition
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
variable "name" {
  description = "Topic Name"
}

variable "resource_group_name" {
  description = "Resource Group Name"
}

variable "azure_bus_namespace" {
  description = "Name for the azure service bus namespace where the topic should be created"
}

variable "enable_partitioning" {
  description = ""
}