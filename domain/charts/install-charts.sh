#!/usr/bin/env bash
set -euox pipefail

chmod 400 ~/.kube/config

IDS=($(az account show --output tsv --query "[id, tenantId]"))

RENDER=$(mktemp)
helm template \
    --values web.values.yaml \
    --set subscriptionId=${IDS[0]} \
    --set tenantId=${IDS[1]} \
    web \
    ./webserver/ \
    > ${RENDER}
code ${RENDER}

helm upgrade \
    --values web.values.yaml \
    --set subscriptionId=${IDS[0]} \
    --set tenantId=${IDS[1]} \
    --install \
    web \
    ./webserver/
sleep 2
rm ${RENDER}