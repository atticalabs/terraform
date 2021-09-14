resource "azurerm_servicebus_topic" "topic" {
  name                = var.name
  resource_group_name = var.resource_group_name
  namespace_name      = var.azure_bus_namespace
  enable_partitioning = var.enable_partitioning
}

output "name" {
  value       = azurerm_servicebus_topic.topic.name
  description = "Topic name"
}