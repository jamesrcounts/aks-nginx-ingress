#!/usr/bin/env bash
set -euox pipefail

terraform fmt

terraform refresh 

TERRAFORM_PLAN=$(mktemp)
terraform plan -refresh=false -out ${TERRAFORM_PLAN}

TERRAFORM_PLAN_TEXT=$(mktemp)
terraform show -no-color ${TERRAFORM_PLAN} > ${TERRAFORM_PLAN_TEXT}
code ${TERRAFORM_PLAN_TEXT}
sleep 2
rm ${TERRAFORM_PLAN_TEXT}
