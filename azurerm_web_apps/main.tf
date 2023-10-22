resource "azurerm_windows_web_app" "webapps" {
  for_each            = var.webapps
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  service_plan_id     = data.azurerm_service_plan.asps[each.key].id
  # site_config {}
  dynamic "site_config" {
    for_each = each.value.site_config
    content {
      always_on         = site_config.value.always_on
      auto_heal_enabled = site_config.value.auto_heal_enabled
    }
  }
}
