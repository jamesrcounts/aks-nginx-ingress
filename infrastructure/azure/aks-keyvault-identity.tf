resource "azurerm_user_assigned_identity" "aks_secret_operator" {
  location            = azurerm_resource_group.main.location
  name                = "aks-secret-operator"
  resource_group_name = azurerm_resource_group.main.name
}