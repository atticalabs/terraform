resource "azurerm_storage_account" "storage" {
  name                     = "${var.function_app_name}strg"
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "plan" {
  name                = "${var.rg_name}-functions-plan"
  location            = var.rg_location
  resource_group_name = var.rg_name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "funcapp" {
  name                       = var.function_app_name
  location                   = var.rg_location
  resource_group_name        = var.rg_name
  app_service_plan_id        = azurerm_app_service_plan.plan.id
  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
}

