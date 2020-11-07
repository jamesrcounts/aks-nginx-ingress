#!/usr/bin/env bash
set -euox pipefail

helm repo add csi-secrets-store-provider-azure https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/master/charts
helm upgrade --install csi-secrets-store-provider csi-secrets-store-provider-azure/csi-secrets-store-provider-azure 

kubectl apply -f secret-provider-class.yaml