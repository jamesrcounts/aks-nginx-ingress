# #!/usr/bin/env bash
# set -euox pipefail

# helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
# helm upgrade --install --values values.yaml gateway ingress-nginx/ingress-nginx

resource "helm_release" "nginx-ingress" {
  name       = "gateway"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  values = [
    file("nginx-ingress/values.yaml")
  ]
}