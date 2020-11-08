resource "helm_release" "keyvault_secrets" {
  name       = "keyvault-secrets-class"
  repository = "charts"
  chart      = "secret-provider"

  values = [local.keyvault_secrets_values]

  set {
    name  = "keyvaultName"
    value = data.azurerm_key_vault.secret_provider.name
  }

  set {
    name  = "resourceGroup"
    value = data.azurerm_resource_group.primary.name
  }

  set {
    name  = "subscriptionId"
    value = data.azurerm_client_config.current.subscription_id
  }

  set {
    name  = "tenantId"
    value = data.azurerm_client_config.current.tenant_id
  }
}

locals {
  keyvault_secrets_values = <<EOF
secrets:
  - name: storage-connection-string-primary
    type: secret
  - name: storage-connection-string-secondary
    type: secret
EOF
}