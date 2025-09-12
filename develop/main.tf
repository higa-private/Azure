# 診断ログの保管ストレージ
#resource "azurerm_storage_account" "diag" {
#  name                     = local.storage_account_diag_name
#  resource_group_name      = azurerm_resource_group.je.name
#  location                 = azurerm_resource_group.je.location
#  account_tier             = "Standard"
#  account_replication_type = "LRS"
#}