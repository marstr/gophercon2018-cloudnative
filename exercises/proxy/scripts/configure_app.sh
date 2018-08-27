# set env vars in managed app per stored env here

base_name=${AZURE_BASE_NAME}
location=${AZURE_DEFAULT_LOCATION}
athens_service=${1:-"proxy"} # or "olympus"
app_name=${2:-"${base_name}-${athens_service}-webapp"}
group_name=${3:-"${base_name}-group"}
redis_name=${4:-"${base_name}-cache"}
cosmosdb_account_name=${5:-"${base_name}-dba"}
# registry_name=${7:-"$(echo ${base_name} | sed 's/[- _]//g')registry"}
# storage_name=${8:-"${base_name}-storage"}

redis_host=$(az redis show --name $redis_name --resource-group ${group_name} \
    --query "[hostName, port]" --output tsv)
redis_host=$(echo $redis_host | tr " " ":")

cosmosdb_id=$(az cosmosdb show --name ${cosmosdb_account_name} --resource-group ${group_name} \
    --output tsv --query id)
mongo_url=$(az cosmosdb list-connection-strings --ids $cosmosdb_id \
    --query "connectionStrings[0].connectionString" --output tsv)

webapp_id=$(az webapp show --name ${app_name} --resource-group ${group_name} --output tsv --query id)
url_suffix=azurewebsites.net
olympus_endpoint=https://${base_name}-olympus-webapp.${url_suffix}
az webapp config appsettings set \
    --ids $webapp_id \
    --settings \
        "ATHENS_REDIS_QUEUE_PORT=${redis_host}" \
        "ATHENS_STORAGE_TYPE=mongo" \
        "ATHENS_MONGO_CONNECTION_STRING=${mongo_url}" \
        "OLYMPUS_GLOBAL_ENDPOINT=${olympus_endpoint}"

