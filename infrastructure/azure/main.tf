locals {
  aks_cluster_name                 = local.project
  aks_kublet_identity_client_id    = azurerm_kubernetes_cluster.aks.kubelet_identity[0].client_id
  aks_kublet_identity_object_id    = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  aks_secret_operator_principal_id = azurerm_user_assigned_identity.aks_secret_operator.principal_id
  aks_system_assigned_principal_id = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  project                          = "aks-nginx-ingress"

  tags = {
    project = local.project
  }
}

resource "random_pet" "server" {
  keepers = {
  }
}

data "azurerm_client_config" "current" {}
