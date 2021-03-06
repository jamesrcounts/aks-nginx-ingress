resource "azurerm_resource_group" "main" {
  location = "centralus"
  name     = "rg-${local.project}"
  tags     = local.tags
}

resource "azurerm_role_assignment" "key_vault_administrator" {
  principal_id         = data.azurerm_client_config.current.object_id
  role_definition_name = "Key Vault Administrator (preview)"
  scope                = azurerm_resource_group.main.id
}

resource "azurerm_role_assignment" "aks_managed_identity_operator" {
  principal_id         = local.aks_kublet_identity_object_id
  role_definition_name = "Managed Identity Operator"
  scope                = azurerm_resource_group.main.id
}

resource "azurerm_role_assignment" "aks_keyvault_reader" {
  principal_id         = azurerm_user_assigned_identity.aks_secret_operator.principal_id
  role_definition_name = "Reader"
  scope                = azurerm_resource_group.main.id
}

resource "azurerm_role_assignment" "aks_keyvault_secret_reader" {
  principal_id         = azurerm_user_assigned_identity.aks_secret_operator.principal_id
  role_definition_name = "Key Vault Secrets User (preview)"
  scope                = azurerm_resource_group.main.id
}

resource "azurerm_role_assignment" "keyvault_crypto_user" {
  principal_id         = azurerm_disk_encryption_set.des.identity.0.principal_id
  role_definition_name = "Key Vault Crypto User (preview)"
  scope                = azurerm_resource_group.main.id
}
