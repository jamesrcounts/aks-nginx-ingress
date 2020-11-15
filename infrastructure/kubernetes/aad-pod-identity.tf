resource "helm_release" "aad_pod_identity" {
  name       = "pod-id"
  repository = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
  chart      = "aad-pod-identity"

  set {
    name  = "nmi.allowNetworkPluginKubenet"
    value = true
  }
}
