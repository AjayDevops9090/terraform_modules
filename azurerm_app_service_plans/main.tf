resource "azurerm_service_plan" "asps" {
  for_each                     = var.asps
  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  os_type                      = each.value.os_type
  sku_name                     = each.value.sku_name
  worker_count                 = each.value.worker_count
  maximum_elastic_worker_count = each.value.maximum_elastic_worker_count
  per_site_scaling_enabled     = each.value.per_site_scaling_enabled
  zone_balancing_enabled       = each.value.zone_balancing_enabled
}