#!/usr/bin/env bash
set -euox pipefail

RENDER=$(mktemp)
helm template --values web.values.yaml web ./webserver/ > ${RENDER}
code ${RENDER}

helm upgrade --values web.values.yaml --install web ./webserver/
#rm ${RENDER}