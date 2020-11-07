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

# resource "azurerm_role_assignment" "key_vault_administrator" {
#   principal_id         = "b55f6ee9-3a4b-42bf-ad67-d02c4632a010"
#   role_definition_name = "Key Vault Administrator (preview)"
#   scope                = azurerm_resource_group.primary.id
# }