data "azurerm_service_plan" "asps" {
  for_each            = var.webapps
  name                = each.value.asp_name
  resource_group_name = each.value.resource_group_name
}