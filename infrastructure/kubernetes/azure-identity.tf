resource "helm_release" "azure_identity_secret_operator" {
  name       = "aks-secret-operator"
  repository = "charts"
  chart      = "azure-identity"

  values = []

  set {
    name  = "userAssignedIdentity.id"
    value = data.azurerm_user_assigned_identity.aks_secret_operator.id
  }

  set {
    name  = "userAssignedIdentity.clientId"
    value = data.azurerm_user_assigned_identity.aks_secret_operator.client_id
  }
}

data "azurerm_user_assigned_identity" "aks_secret_operator" {
  name                = "aks-secret-operator"
  resource_group_name = data.azurerm_resource_group.primary.name
}