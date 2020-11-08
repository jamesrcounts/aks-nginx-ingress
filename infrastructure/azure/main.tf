locals {
  project                          = "aks-nginx-ingress"
  aks_system_assigned_principal_id = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  aks_cluster_name                 = local.project

  tags = {
    Environment = "Test"
  }
}

resource "random_pet" "server" {
  keepers = {
  }
}

data "azurerm_client_config" "current" {}
