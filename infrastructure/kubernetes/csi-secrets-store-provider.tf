resource "helm_release" "secrets_store_provider" {
  chart      = "csi-secrets-store-provider-azure"
  name       = "keyvault-secrets"
  namespace  = kubernetes_namespace.platform.metadata.0.name
  repository = "https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/master/charts"
}