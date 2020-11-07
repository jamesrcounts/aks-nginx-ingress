locals {
  project = "test"

  tags = {
    Environment = "Test"
  }
}

resource "random_pet" "server" {
  keepers = {
  }
}

data "azurerm_client_config" "current" {}
