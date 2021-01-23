resource "kubernetes_namespace" "platform" {
  metadata {
    name = "platform"

    annotations = {
      name = "platform"
    }

    labels = {
      purpose = "platform"
    }
  }
}

resource "kubernetes_namespace" "customer" {
  for_each = toset(["customer1", "customer2"])
  metadata {
    name = each.value

    annotations = {
      name = each.value
    }

    labels = {
      purpose  = "workload"
      customer = each.value
    }
  }
}