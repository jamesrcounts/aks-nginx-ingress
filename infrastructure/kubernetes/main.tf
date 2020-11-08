locals {
  project = "aks-nginx-ingress"
}

resource "random_pet" "fido" {}

data "azurerm_client_config" "current" {}
