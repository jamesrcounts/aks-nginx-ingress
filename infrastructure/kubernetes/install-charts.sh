#!/usr/bin/env bash
set -euox pipefail

pushd ./csi-secrets-store-provider-azure
./install.sh
popd

pushd ./nginx-ingress
./install.sh
popd