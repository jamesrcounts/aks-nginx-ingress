resource "helm_release" "nginx_ingress" {
  depends_on = [helm_release.keyvault_certs]
  name       = "gateway"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  values = [
    file("nginx-ingress/values.yaml")
  ]
}