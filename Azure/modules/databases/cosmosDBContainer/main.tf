resource "azurerm_cosmosdb_sql_container" "container" {
  name                  = var.container_name
  resource_group_name   = var.resource_group_name
  account_name          = var.db_account_name
  database_name         = var.db_name
  partition_key_path    = var.pkey_path  

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}