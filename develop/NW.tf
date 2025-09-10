resource "azurerm_resource_group" "develop" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    owner         = var.tags_owner
    resourcegroup = var.tags_resourcegroup
    environment   = var.tags_environment
  }
}

resource "azurerm_virtual_network" "develop_vnet" {
  name                = var.virtual_network_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.develop.location
  resource_group_name = azurerm_resource_group.develop.name
  tags = {
    owner = var.tags_owner
    vnet  = var.tags_vnet
  }
}

resource "azurerm_subnet" "develop_subnet" {
  count                = length(var.develop_subnet_name)
  name                 = var.develop_subnet_name[count.index]
  resource_group_name  = azurerm_resource_group.develop.name
  virtual_network_name = azurerm_virtual_network.develop_vnet.name
  address_prefixes     = [var.develop_subnet_address_prefixes[count.index]]
  service_endpoints    = var.develop_subnet_name[count.index] == "vm-subnet" ? var.develop_service_endpoints : []
}