resource "helm_release" "aad_pod_identity" {
  chart      = "aad-pod-identity"
  name       = "pod-id"
  namespace  = kubernetes_namespace.platform.metadata.0.name
  repository = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"

  set {
    name  = "nmi.allowNetworkPluginKubenet"
    value = true
  }
}
