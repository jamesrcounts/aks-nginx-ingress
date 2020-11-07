locals {
  project          = "test"
  aks_cluster_name = "aks-${local.project}"
  tags = {
    Environment = "Test"
  }
}

resource "random_pet" "server" {
  keepers = {
  }
}

data "azurerm_client_config" "current" {}
