#!/usr/bin/env bash
set -euox pipefail

ID=$(uuidgen)
LOCATION_PRIMARY=centralus
LOCATION_BACKUP=eastus2
TAG="terraform"

declare -A RGS
declare -A ACCOUNTS

# Get the caller identity
CALLER_ID=$(
  az ad signed-in-user show \
    --query "objectId" \
    --output tsv
)

function storage_replica {
  local LOCATION=$1

  # Create unique name for resource group
  local RG=$(echo "rg-${TAG}-backend-${LOCATION}-${ID}" | cut -c1-36)
  RGS+=([${LOCATION}]=${RG})

  # Create unique name for storage account
  local STORAGE_ACCOUNT=$(echo "sa-${TAG}-${LOCATION}-${ID}" | tr '[:upper:]' '[:lower:]' | sed 's/-//g' | cut -c1-24)
  ACCOUNTS+=([${LOCATION}]=${STORAGE_ACCOUNT})

  # Create Resource Group for Backend Storage
  local RG_ID=$(
    az group create \
      --location "${LOCATION}" \
      --name "${RG}" \
      --query "id" \
      --output tsv
  )

  # Make the caller a data contributor
  az role assignment create \
    --assignee "${CALLER_ID}" \
    --role "Storage Account Contributor" \
    --scope "${RG_ID}"

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
    --auth-mode login \
    --name ${TAG}
}

storage_replica ${LOCATION_PRIMARY}
storage_replica ${LOCATION_BACKUP}

# Create a policy on the destination account
POLICY_ID=$(
  az storage account or-policy create \
    --resource-group ${RGS[${LOCATION_BACKUP}]} \
    --account-name ${ACCOUNTS[${LOCATION_BACKUP}]} \
    --source-account ${ACCOUNTS[${LOCATION_PRIMARY}]} \
    --source-container ${TAG} \
    --destination-container ${TAG} \
    --min-creation-time "1601-01-01T00:00:00Z" \
    --query "policyId" \
    --output tsv
)

# Create the same policy on the source account
az storage account or-policy show \
    --resource-group ${RGS[${LOCATION_BACKUP}]} \
    --account-name ${ACCOUNTS[${LOCATION_BACKUP}]} \
    --policy-id ${POLICY_ID} |
    az storage account or-policy create --resource-group ${RGS[${LOCATION_PRIMARY}]} \
    --account-name ${ACCOUNTS[${LOCATION_PRIMARY}]} \
    --policy "@-"