resource "azurerm_role_assignment" "vm_identity_subscription_reader" {
  scope                = "/subscriptions/${var.provider_credentials.subscription_id}"
  role_definition_name = "Reader"
  principal_id         = azurerm_linux_virtual_machine.vm.identity[0].principal_id

  depends_on = [
    azurerm_linux_virtual_machine.vm
  ]
}

# Key VaultのSecrets Officerロール定義を取得
data "azurerm_role_definition" "secrets_officer" {
  name = "Key Vault Secrets Officer"
}

# Key VaultのSecrets Officerロールをユーザーに割り当てる
resource "azurerm_role_assignment" "key_vault_secret_writer" {
  # ロールを割り当てるスコープ
  scope = azurerm_key_vault.develop.id
  # 割り当てるロールのID
  role_definition_id = data.azurerm_role_definition.secrets_officer.id
  # ロールを割り当てるユーザーのプリンシパルID
  principal_id = var.owner_prinscipal_id
}
