# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE APPLICATION INSIGHTS FOR CORE API
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
resource "azurerm_application_insights" "app_insights" {
  name                = "${var.name}-insights"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CREATE CORE API
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
resource "azurerm_app_service" "api" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id

  site_config {
    dotnet_framework_version  = "v4.0"
    use_32_bit_worker_process = true
    remote_debugging_enabled  = true
    remote_debugging_version  = "VS2017"
    always_on                 = false

    cors {
      allowed_origins = var.cors_allowed_origins
    }
    default_documents = ["index.html"]
  }

  app_settings = merge({
    APPINSIGHTS_INSTRUMENTATIONKEY             = azurerm_application_insights.app_insights.instrumentation_key
    ApplicationInsightsAgent_EXTENSION_VERSION = "~2"
    XDT_MicrosoftApplicationInsights_Mode      = "recommended"
    ASPNETCORE_ENVIRONMENT                     = var.aspnet_environment
    WEBSITE_NODE_DEFAULT_VERSION               = var.appsettings_node_version
  }, var.app_settings)

  dynamic "connection_string" {
    for_each = var.connection_strings
    content {
      name  = connection_string.value["name"]
      type  = connection_string.value["type"]
      value = connection_string.value["value"]
    }
  }
}


output "hostname" {
  value       = azurerm_app_service.api.default_site_hostname
  description = "The default hostname of the web app."
}

output "plan" {
  value = {
    id = azurerm_app_service.api.app_service_plan_id
  }
  description = "App Service plan properties for the web app."
}

output "outbound_ips" {
  value       = split(",", azurerm_app_service.api.outbound_ip_addresses)
  description = "A list of outbound IP addresses for the web app."
}

