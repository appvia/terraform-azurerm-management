module "alz" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "6.2.0"

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

  default_location = var.primary_location

  # Base module configuration settings
  root_parent_id = data.azurerm_client_config.current.tenant_id
  root_id        = var.root_id

  # Disable creation of the core management group hierarchy
  # as this is being created by the core module instance
  deploy_core_landing_zones = false

  disable_telemetry = true

  # Configuration settings for management resources
  deploy_management_resources    = true
  configure_management_resources = var.management_resources_configuration
  subscription_id_management     = data.azurerm_client_config.current.subscription_id
}

resource "azurerm_monitor_action_group" "platform_action_group" {
  for_each            = { for k, v in module.alz.azurerm_resource_group.management : "mgmt" => v if endswith(v.name, "-mgmt") }
  name                = "PlatformActionGroup"
  resource_group_name = each.value.name
  short_name          = "pag"

  tags = var.management_resources_tags

  email_receiver {
    name                    = "SecurityContact"
    email_address           = var.management_resources_configuration.settings.security_center.config.email_security_contact
    use_common_alert_schema = true
  }
}
