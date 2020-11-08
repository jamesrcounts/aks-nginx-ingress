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
  principal_id         = local.aks_system_assigned_principal_id
  role_definition_name = "Managed Identity Operator"
  scope                = azurerm_resource_group.main.id
}