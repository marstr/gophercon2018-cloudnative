#!/usr/bin/env bash

base_name=${1:-"${AZURE_BASE_NAME}"}
group_name=${2:-"${base_name}-group"}
redis_name=${3:-"${base_name}-cache"}
cosmosdb_account_name=${4:-"${base_name}-dba"}
# storage_name=${5:-"${base_name}-storage"}
location=${6:-${AZURE_DEFAULT_LOCATION}}

# TODO: add tracing
# TODO: add auth

ensure_group ${group_name}

## setup CosmosDB/Mongo
cosmosdb_account_id=$(az cosmosdb show --name ${cosmosdb_account_name} --resource-group ${group_name} \
	--output tsv --query id 2> /dev/null)
if [[ -z "$cosmosdb_account_id" ]]; then
	cosmosdb_account_id=$(az cosmosdb create \
		--name ${cosmosdb_account_name} \
		--resource-group ${group_name} \
		--kind MongoDB \
		--output tsv --query id)
fi
echo "created cosmosdb account: ${cosmosdb_account_id}"

db_name=athens
coll_name=modules
cosmos_string="--db-name $db_name --name ${cosmosdb_account_name} --resource-group-name ${group_name}"
cosmosdb_db_id=$(az cosmosdb database show $cosmos_string --output tsv --query _self)
if [[ -z "$cosmosdb_db_id" ]]; then
	cosmosdb_db_id=$(az cosmosdb database create $cosmos_string --output tsv --query _self)
fi
echo "created cosmosdb database: ${cosmosdb_db_id}"

cosmosdb_coll_id=$(az cosmosdb collection show ${cosmos_string} \
	--collection-name $coll_name \
	--output tsv --query collection._self)
if [[ -z "$cosmosdb_coll_id" ]]; then
cosmosdb_coll_id=$(az cosmosdb collection create ${cosmos_string} \
	--collection-name $coll_name \
	--output tsv --query collection._self)
fi
echo "created cosmosdb collection: ${cosmosdb_coll_id}"

## ensure redis
redis_id=$(az redis show --name $redis_name --resource-group $group_name \
    --output tsv --query id 2> /dev/null)
if [[ -z $redis_id ]]; then
    redis_id=$(az redis create \
        --name $redis_name \
        --resource-group $group_name \
        --location $location \
        --sku 'Standard' \
        --vm-size C4 \
        --enable-non-ssl-port \
        --query id --output tsv)
fi
redis_key=$(az redis list-keys \
    --ids $redis_id \
    --query primaryKey --output tsv)
echo "ensure redis_id: $redis_id"
echo "redis primaryKey: [$redis_key]"
