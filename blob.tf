# Create storage account for boot diagnostics
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  location                 = azurerm_resource_group.develop.location
  resource_group_name      = azurerm_resource_group.develop.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Blob コンテナ
resource "azurerm_storage_container" "tfstate_container" {
  name                  = "tfstate20250911"
  storage_account_id    = azurerm_storage_account.storage_account.id
  container_access_type = "private"
}