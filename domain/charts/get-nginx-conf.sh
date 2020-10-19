#!/usr/bin/env bash
set -euox pipefail

POD=$(
    kubectl get pod \
        -l app.kubernetes.io/component=controller,app.kubernetes.io/instance=gateway,app.kubernetes.io/name=ingress-nginx \
        -o name
)

CONF=$(mktemp)
kubectl exec -it ${POD} -- cat /etc/nginx/nginx.conf > ${CONF} 
code ${CONF}
sleep 1
rm ${CONF}