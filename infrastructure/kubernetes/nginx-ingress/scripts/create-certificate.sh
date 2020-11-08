#!/usr/bin/env bash
set -euox pipefail

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out ingress-tls.crt \
    -keyout ingress-tls.key \
    -subj "/CN=www.olive-steel.com/O=ingress-tls"

cat ingress-tls.key > ingress-tls.pem
cat ingress-tls.crt >> ingress-tls.pem