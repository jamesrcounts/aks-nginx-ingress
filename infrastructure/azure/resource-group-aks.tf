resource "azurerm_role_assignment" "aks_nodes_managed_identity_operator" {
  principal_id         = local.aks_system_assigned_principal_id
  role_definition_name = "Managed Identity Operator"
  scope                = local.node_resource_group_id
}

resource "azurerm_role_assignment" "aks_nodes_virtual_machine_contributor" {
  principal_id         = local.aks_system_assigned_principal_id
  role_definition_name = "Virtual Machine Contributor"
  scope                = local.node_resource_group_id
}

locals {
  node_resource_group_id = replace(
    azurerm_resource_group.main.id,
    azurerm_resource_group.main.name,
    azurerm_kubernetes_cluster.aks.node_resource_group
  )
}