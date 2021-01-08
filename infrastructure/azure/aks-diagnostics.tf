locals {
  aks_diagnostics = sort([
    "cluster-autoscaler",
    "guard",
    "kube-apiserver",
    "kube-audit",
    "kube-audit-admin",
    "kube-controller-manager",
    "kube-scheduler",
  ])
}

resource "azurerm_monitor_diagnostic_setting" "aks_log_storage" {
  name               = "aks-log-storage"
  target_resource_id = azurerm_kubernetes_cluster.aks.id
  storage_account_id = azurerm_storage_account.diagnostics.id

  dynamic "log" {
    for_each = local.aks_diagnostics
    content {
      category = log.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = 17
      }
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 30
    }
  }
}