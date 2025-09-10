# Create public IPs
resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.develop.location
  resource_group_name = azurerm_resource_group.develop.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "develop_nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.develop.location
  resource_group_name = azurerm_resource_group.develop.name

  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.direction == "Outbound" ? var.nsg_outbound_ip : var.nsg_inbound_ip
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

# Create network interface
resource "azurerm_network_interface" "develop_nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.develop.location
  resource_group_name = azurerm_resource_group.develop.name

  ip_configuration {
    name                          = "runner-ip"
    subnet_id                     = azurerm_subnet.develop_subnet[0].id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "develop_nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.develop_nic.id
  network_security_group_id = azurerm_network_security_group.develop_nsg.id
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  location                 = azurerm_resource_group.develop.location
  resource_group_name      = azurerm_resource_group.develop.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  computer_name                   = var.vm_name # VMのホスト名として設定される
  admin_username                  = var.admin_username
  disable_password_authentication = "true"
  location                        = azurerm_resource_group.develop.location
  resource_group_name             = azurerm_resource_group.develop.name
  network_interface_ids           = [azurerm_network_interface.develop_nic.id]
  size                            = "Standard_B1s"
  #custom_data                     = filebase64("userdata/cloud-init.txt")

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = var.osdisk_name
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = "Almalinux"
    offer     = "almalinux-x86_64"
    sku       = "9-gen2"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }
}


#  boot_diagnostics {
#    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
#  }
#}
#
## Install IIS web server to the virtual machine
#resource "azurerm_virtual_machine_extension" "web_server_install" {
#  name                       = "${random_pet.prefix.id}-wsi"
#  virtual_machine_id         = azurerm_windows_virtual_machine.main.id
#  publisher                  = "Microsoft.Compute"
#  type                       = "CustomScriptExtension"
#  type_handler_version       = "1.8"
#  auto_upgrade_minor_version = true
#
#  settings = <<SETTINGS
#    {
#      "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
#    }
#  SETTINGS
#}
#
## Generate random text for a unique storage account name
#resource "random_id" "random_id" {
#  keepers = {
#    # Generate a new ID only when a new resource group is defined
#    resource_group = azurerm_resource_group.rg.name
#  }
#
#  byte_length = 8
#}
#
#resource "random_password" "password" {
#  length      = 20
#  min_lower   = 1
#  min_upper   = 1
#  min_numeric = 1
#  min_special = 1
#  special     = true
#}
#
#resource "random_pet" "prefix" {
#  prefix = var.prefix
#  length = 1
#}