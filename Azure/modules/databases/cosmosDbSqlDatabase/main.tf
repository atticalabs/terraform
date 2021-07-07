resource "azurerm_cosmosdb_account" "acct" {
  name                = var.account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  } 

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}

resource "azurerm_cosmosdb_sql_database" "db" {
  name                = var.db_name
  resource_group_name = var.resource_group_name
  account_name        = var.account_name
  throughput          = var.privisioned_throughput
}


output "connection_string" {
  description = "Connection string for the CosmosDB Database"
  value       = azurerm_cosmosdb_account.acct.endpoint
}

output "account_name" {  
  value       = azurerm_cosmosdb_sql_database.db.account_name
}

output "db_name" {  
  value       = azurerm_cosmosdb_sql_database.db.name
}