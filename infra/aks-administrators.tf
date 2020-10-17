resource "azuread_group" "aks_administrators" {
  name = "aks-administrators"
}

resource "azuread_group_member" "aks_administrator" {
  group_object_id  = azuread_group.aks_administrators.id
  member_object_id = data.azuread_user.current.id
}

data "azuread_user" "current" {
  object_id = data.azurerm_client_config.current.object_id
}

data "azurerm_client_config" "current" {
}
