data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "develop" {
  name                       = var.key_vault_name
  location                   = azurerm_resource_group.develop.location
  resource_group_name        = azurerm_resource_group.develop.name
  tenant_id                  = var.provider_credentials.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  rbac_authorization_enabled = true
  enabled_for_deployment     = true
}

resource "azurerm_role_assignment" "key_vault_officer" {
  scope                = azurerm_key_vault.develop.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id

  # Key Vaultリソースの作成後、このロール割り当てが実行される
  depends_on = [
    azurerm_key_vault.develop
  ]
}

resource "azurerm_key_vault_secret" "develop_secret" {
  count        = length(var.develop_secret_name)
  name         = var.develop_secret_name[count.index]
  value        = "test" # シークレットの値なので作成後に変更
  key_vault_id = azurerm_key_vault.develop.id

  depends_on = [
    azurerm_role_assignment.key_vault_officer
  ]

  lifecycle {
    ignore_changes = [
      # Key Vaultの値は作成後に変更するので無視
      value,
    ]
  }
}

# VMのマネージドIDにロールを割り当てるリソース
resource "azurerm_role_assignment" "vm_keyvault_secrets_reader" {
  # 割り当てのスコープはKey Vault
  scope                = azurerm_key_vault.develop.id
  # 割り当てるロール名
  role_definition_name = "Key Vault Secrets Officer"
  # 割り当てる対象はVMのマネージドIDのプリンシパルID
  principal_id         = azurerm_linux_virtual_machine.vm.identity[0].principal_id

  # 依存関係を明示
  depends_on = [
    azurerm_key_vault.develop,
    azurerm_linux_virtual_machine.vm
  ]
}