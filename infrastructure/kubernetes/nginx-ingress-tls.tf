resource "helm_release" "keyvault_certs" {
  name       = "keyvault-cert-class"
  repository = "charts"
  chart      = "secret-provider"

  values = [local.keyvault_cert_values]

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
  keyvault_cert_values = <<EOF
secretObjects: 
- secretName: ingress-tls-csi
  type: kubernetes.io/tls
  data: 
  - objectName: ingress-tls
    key: tls.key
  - objectName: ingress-tls
    key: tls.crt

secrets:
  - name: ingress-tls
    type: secret
EOF
}