#!/usr/bin/env bash
set -euox pipefail

chmod 400 ~/.kube/config

RENDER=$(mktemp)
helm template --values web.values.yaml web ./webserver/ > ${RENDER}
code ${RENDER}

helm upgrade --values web.values.yaml --install web ./webserver/
sleep 2
rm ${RENDER}