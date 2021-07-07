output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_name" {
  value = azurerm_storage_account.sa.name
}

output "sas_token" {
  value = data.azurerm_storage_account_sas.state.sas
}
