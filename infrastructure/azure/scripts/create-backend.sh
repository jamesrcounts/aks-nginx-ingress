#!/usr/bin/env bash
set -euo pipefail

ID=$(uuidgen)
LOCATION=centralus

TAG="terraform"

# Create unique name for resource group
RG=$(echo "rg-${TAG}-backend-${ID}" | cut -c1-24)

# Create unique name for storage account
STORAGE_ACCOUNT=$(echo "sa-${TAG}-${ID}" | tr '[:upper:]' '[:lower:]' | sed 's/-//g' | cut -c1-24)

# Create Resource Group for Backend Storage
az group create \
  --location ${LOCATION} \
  --name ${RG}

# Create Geo-Redundant Storage Account
az storage account create \
  --kind StorageV2 \
  --location ${LOCATION} \
  --name "${STORAGE_ACCOUNT}" \
  --resource-group ${RG}  \
  --sku Standard_GRS \
  --allow-blob-public-access false \
  --min-tls-version TLS1_2

# Enable blob data protection
az storage account blob-service-properties update \
    --account-name "${STORAGE_ACCOUNT}" \
    --delete-retention-days 365 \
    --enable-change-feed true \
    --enable-delete-retention true \
    --enable-versioning true \
    --enable-restore-policy true \
    --restore-days 256

# Create storage container
az storage container create \
  --account-name "${STORAGE_ACCOUNT}" \
  --name ${TAG}