resource "helm_release" "nginx_ingress" {
  name       = "gateway"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  values = [
    file("nginx-ingress/values.yaml")
  ]
}