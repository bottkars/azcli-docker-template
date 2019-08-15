#!/bin/bash
pushd $(pwd)
cd "$(dirname "$0")"
source ../vars/.secrets
set -eux
source ../vars/.env.sh
if [ -z "${CA_CERT}" ]
then
    echo "no custom root ca found"
else
    cat ../certs/${CA_CERT} >> ${AZURE_CLI_CA_PATH} 
fi

az cloud register -n AzureStackUser \
--endpoint-resource-manager ${ENDPOINT_RESOURCE_MANAGER} \
--suffix-storage-endpoint ${SUFFIX_STORAGE_ENDPOINT} \
--suffix-keyvault-dns ${VAULT_DNS} \
--profile ${PROFILE}
az cloud set -n AzureStackUser
set +eux
if [ -z "${AZURE_CLIENT_ID}" ] || [ -z "${AZURE_CLIENT_SECRET}"  ]
then
    echo "no Client Credentials found, skipping login"
else
    az login --service-principal \
    -u ${AZURE_CLIENT_ID} \
    -p ${AZURE_CLIENT_SECRET} \
    --tenant ${AZURE_TENANT_ID}  
    az account set --subscription ${AZURE_SUBSCRIPTION_ID}
fi
