#!/usr/bin/env bash
set -euox pipefail

CUSTOMER=${1}
IDS=($(az account show --output tsv --query "[id, tenantId]"))

helm upgrade \
    --values ${CUSTOMER}.values.yaml \
    --set subscriptionId=${IDS[0]} \
    --set tenantId=${IDS[1]} \
    --install \
    --namespace ${CUSTOMER} \
    web \
    ./webserver/