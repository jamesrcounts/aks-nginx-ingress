resource "helm_release" "azure_identity_secret_operator" {
  chart      = "azure-identity"
  name       = "aks-secret-operator"
  namespace  = kubernetes_namespace.platform.metadata.0.name
  repository = "charts"

  values = []

  set {
    name  = "userAssignedIdentity.id"
    value = data.azurerm_user_assigned_identity.aks_secret_operator.id
  }

  set {
    name  = "userAssignedIdentity.clientId"
    value = data.azurerm_user_assigned_identity.aks_secret_operator.client_id
  }

  set {
    name  = "userAssignedIdentity.tenantId"
    value = data.azurerm_client_config.current.tenant_id
  }
}

data "azurerm_user_assigned_identity" "aks_secret_operator" {
  name                = "aks-secret-operator"
  resource_group_name = data.azurerm_resource_group.primary.name
}