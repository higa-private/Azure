data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "develop" {
  name                       = var.key_vault_name
  location                   = azurerm_resource_group.develop.location
  resource_group_name        = azurerm_resource_group.develop.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  rbac_authorization_enabled = true
  enabled_for_deployment     = true
}

#resource "azurerm_role_assignment" "develop_secret_officer" {
#  scope                = azurerm_key_vault.develop.id
#  role_definition_name = "Key Vault Secrets Officer"
#  principal_id         = data.azurerm_client_config.current.object_id
#}

resource "azurerm_key_vault_secret" "develop_secret" {
  count        = length(var.develop_secret_name)
  name         = var.develop_secret_name[count.index]
  value        = "test"           # シークレットの値なので作成後に変更
  key_vault_id = azurerm_key_vault.develop.id

  lifecycle { 
    ignore_changes = [
      # Key Vaultの値は作成後に変更するので無視
      value,
    ]
  }
}