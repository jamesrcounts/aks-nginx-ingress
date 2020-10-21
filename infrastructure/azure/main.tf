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
