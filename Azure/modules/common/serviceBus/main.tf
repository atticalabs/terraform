
resource "azurerm_servicebus_namespace" "azbus" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
}

output "name" {
  value       = azurerm_servicebus_namespace.azbus.name
  description = "Bus name"
}

output "connection_string" {
  value       = azurerm_servicebus_namespace.azbus.default_primary_connection_string
  description = "Namespace of the service bus."
}