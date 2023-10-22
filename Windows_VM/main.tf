data "azurerm_key_vault" "example" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg
}

data "azurerm_key_vault_secret" "username" {
  name         = var.keyvault_username
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "password" {
  name         = var.keyvault_password
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_subnet" "frontend_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}

resource "azurerm_public_ip" "example" {
  for_each            = var.Windows_virtual_machine
  name                = each.value.public_ip
  resource_group_name = var.rg_name
  location            = each.value.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.Windows_virtual_machine
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.frontend_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example[each.key].id
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  for_each            = var.Windows_virtual_machine
  name                = each.value.vm_name
  resource_group_name = var.rg_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = data.azurerm_key_vault_secret.username.value
  admin_password      = data.azurerm_key_vault_secret.password.value


  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}