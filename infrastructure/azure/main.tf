locals {
  project          = "aks-nginx-ingress"
  aks_cluster_name = local.project
  tags = {
    Environment = "Test"
  }
}

resource "random_pet" "server" {
  keepers = {
  }
}

data "azurerm_client_config" "current" {}
