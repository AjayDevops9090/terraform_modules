data "azurerm_subnet" "subnet" {
  name                 = "LinSubnet-1"
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}