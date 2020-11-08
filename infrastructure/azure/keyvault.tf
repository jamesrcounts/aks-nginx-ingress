resource "azurerm_key_vault" "secret_provider" {
  enable_rbac_authorization       = true
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  location                        = azurerm_resource_group.main.location
  name                            = "kv-${local.project}"
  resource_group_name             = azurerm_resource_group.main.name
  sku_name                        = "standard"
  soft_delete_enabled             = true
  soft_delete_retention_days      = 30
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  tags                            = local.tags

  # contact {
  #   email = "joe@olive-steel.com"
  #   name  = "Joe Secrets"
  #   phone = "(555) 555-5555"
  # }
}

resource "azurerm_key_vault_secret" "storage_connection_string_primary" {
  name         = "storage-connection-string-primary"
  value        = azurerm_storage_account.diagnostics.primary_connection_string
  key_vault_id = azurerm_key_vault.secret_provider.id
  tags         = local.tags
}

resource "azurerm_key_vault_secret" "storage_connection_string_secondary" {
  name         = "storage-connection-string-secondary"
  value        = azurerm_storage_account.diagnostics.secondary_connection_string
  key_vault_id = azurerm_key_vault.secret_provider.id
  tags         = local.tags
}

# resource "azurerm_key_vault_secret" "redis_access_key_primary" {
#   name         = "redis-access-key-primary"
#   value        = azurerm_redis_cache.cache.primary_access_key
#   key_vault_id = azurerm_key_vault.credential_proxy.id
#   tags         = local.tags
# }

# resource "azurerm_key_vault_secret" "redis_access_key_secondary" {
#   name         = "redis-access-key-secondary"
#   value        = azurerm_redis_cache.cache.secondary_access_key
#   key_vault_id = azurerm_key_vault.credential_proxy.id
#   tags         = local.tags
# }