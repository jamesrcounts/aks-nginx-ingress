resource "helm_release" "nginx_ingress" {
  depends_on = [helm_release.keyvault_certs]

  chart      = "ingress-nginx"
  name       = "gateway"
  namespace  = kubernetes_namespace.platform.metadata.0.name
  repository = "https://kubernetes.github.io/ingress-nginx"

  values = [
    file("nginx-ingress/values.yaml")
  ]
}