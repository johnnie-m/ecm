#!/bin/bash

source $CREDS
envUrl=${ENV}_URL; vltUrl=${!envUrl}; echo $vltUrl
envUsr=${ENV}_USER; vltUsr=${!envUsr}; echo $vltUsr
envPwd=${ENV}_PASS; vltPwd=${!envPwd}; echo $vltPwd

JSON=$( jq -n \
    --arg password $vltPwd \
    '$ARGS.named')
echo $JSON
# Fetch vault user token
curl "${vltUrl}/v1/auth/userpass/login/${vltUsr}" --data "$JSON" | jq -r '.auth.client_token'
C_TOKEN=$(curl "${vltUrl}/v1/auth/userpass/login/${vltUsr}" --data "$JSON" 2</dev/null | jq -r '.auth.client_token')
echo $C_TOKEN
# Fetch secrets and export to environment variables
export HOSTNAME=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.HOSTNAME')
export IMG_REP=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.IMG_REP')
export SU_EMAIL=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.SU_EMAIL')
export SU_PASS=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.SU_PASS')
export PSQL_URL=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.PSQL_URL')
export RO_POSTGRES_URL=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.RO_POSTGRES_URL')
export MONGO_URL=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.MONGO_URL')
export VAHTER_MONGO_URL=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.VAHTER_MONGO_URL')
export REDIS_URL=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.REDIS_URL')
export AMQP_URL=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.AMQP_URL')
export S3_SECRET=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.S3_SECRET')
export S3_KEY=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.S3_KEY')
export S3_BUCKET=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.S3_BUCKET')
export S3_BACKEND_ADDRESS=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.S3_BACKEND_ADDRESS')
export S3_REGION=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.S3_REGION')
export S3_SSL_ENABLED=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.S3_SSL_ENABLED')
export SMTP_HOST=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.SMTP_HOST')
export SMTP_PORT=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.SMTP_PORT')
export SMTP_FROM=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.SMTP_FROM')
export SMTP_USER=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.SMTP_USER')
export SMTP_PASS=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.SMTP_PASS')
#export ELMA365_AMQP_URL=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.ELMA365_AMQP_URL')
#export ELMA365_MONGO_DB_NAME=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.ELMA365_MONGO_DB_NAME')
#export ELMA365_MONGO_PASSWORD=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.ELMA365_MONGO_PASSWORD')
#export ELMA365_MONGO_USER=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.ELMA365_MONGO_USER')
#export ELMA365_POSTGRES_DB_NAME=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.ELMA365_POSTGRES_DB_NAME')
#export ELMA365_POSTGRES_PASSWORD=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.ELMA365_POSTGRES_PASSWORD')
#export ELMA365_POSTGRES_USER=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.ELMA365_POSTGRES_USER')
#export ELMA365_RABBITMQ_HOST=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.ELMA365_RABBITMQ_HOST')
#export ELMA365_RABBITMQ_PASSWORD=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.ELMA365_RABBITMQ_PASSWORD')
#export ELMA365_RABBITMQ_USER=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.ELMA365_RABBITMQ_USER')
#export ELMA365_RABBITMQ_VH_NAME=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.ELMA365_RABBITMQ_VH_NAME')
#export PSQL_URL=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.PSQL_URL')
#export S3_UPLOAD_METHOD=$(curl -H "X-Vault-Token: ${C_TOKEN}" -X GET ${vltUrl}/v1/medpult/data/elma365 2</dev/null | jq -r '.data.data.S3_UPLOAD_METHOD')

# Substitute variables to values file
envsubst < values.yml > values-temp.yml
echo "showing values.yml"
echo "------------------------------------------------------"
cat values-temp.yml
echo "------------------------------------------------------"
