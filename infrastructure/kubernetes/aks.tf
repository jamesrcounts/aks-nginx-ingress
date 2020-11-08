data "azurerm_kubernetes_cluster" "aks" {
  name                = local.project
  resource_group_name = data.azurerm_resource_group.primary.name
}