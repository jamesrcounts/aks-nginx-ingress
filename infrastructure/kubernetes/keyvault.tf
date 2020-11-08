data "azurerm_key_vault" "secret_provider" {
  name                = "kv-${local.project}"
  resource_group_name = data.azurerm_resource_group.primary.name
}