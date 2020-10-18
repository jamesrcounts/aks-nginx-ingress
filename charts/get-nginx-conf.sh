#!/usr/bin/env bash
set -euox pipefail

CONF=$(mktemp)
kubectl exec -it gateway-ingress-nginx-controller-qcnwr -- cat /etc/nginx/nginx.conf > ${CONF} 
code ${CONF}
sleep 1
rm ${CONF}