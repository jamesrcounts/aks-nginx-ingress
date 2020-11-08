resource "azurerm_role_assignment" "aks_nodes_managed_identity_operator" {
  principal_id         = local.aks_system_assigned_principal_id
  role_definition_name = "Managed Identity Operator"
  scope                = data.azurerm_resource_group.aks_nodes.id
}

resource "azurerm_role_assignment" "aks_nodes_virtual_machine_contributor" {
  principal_id         = local.aks_system_assigned_principal_id
  role_definition_name = "Virtual Machine Contributor"
  scope                = data.azurerm_resource_group.aks_nodes.id
}

data "azurerm_resource_group" "aks_nodes" {
  name = azurerm_kubernetes_cluster.aks.node_resource_group
}