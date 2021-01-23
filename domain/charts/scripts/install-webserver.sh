#!/usr/bin/env bash
set -euox pipefail

NAMESPACE=${1}
IDS=($(az account show --output tsv --query "[id, tenantId]"))

helm upgrade \
    --values web.values.yaml \
    --set subscriptionId=${IDS[0]} \
    --set tenantId=${IDS[1]} \
    --install \
    --namespace ${NAMESPACE} \
    web \
    ./webserver/