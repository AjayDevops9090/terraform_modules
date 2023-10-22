data "azurerm_virtual_network" "vnetid" {
  for_each            = var.vnet_peering
  name                = each.value.local_peering_Vnet
  resource_group_name = each.value.local_peering_rg
}

resource "azurerm_virtual_network_peering" "peering" {
  for_each                  = var.vnet_peering
  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.virtual_network_name
  remote_virtual_network_id = data.azurerm_virtual_network.vnetid[each.key].id
}

