data "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${local.project}"
  resource_group_name = data.azurerm_resource_group.primary.name
}