resource "azurerm_key_vault" "os_encryption" {
  enable_rbac_authorization       = true
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = false
  location                        = azurerm_resource_group.main.location
  name                            = "kv-${local.project}-des"
  resource_group_name             = azurerm_resource_group.main.name
  sku_name                        = "standard"
  soft_delete_retention_days      = 30
  purge_protection_enabled        = true
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  tags                            = local.tags
}

resource "azurerm_key_vault_key" "des" {
  name         = "des-key-${local.project}"
  key_vault_id = azurerm_key_vault.os_encryption.id
  key_type     = "RSA"
  key_size     = 2048
  tags         = local.tags

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}
