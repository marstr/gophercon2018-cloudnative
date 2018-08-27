# Go Modules Proxy

In this lab you will create a database and two services running a Go module
proxy and module registry based on [project
Athens](https://github.com/gomods/athens).

In `./scripts` you'll find prewritten scripts to do this.

# Details

1. Use your assigned resource group to create an image registry and build images.

  ```bash
  group_name=from_above
  registry_name=<your_name>goproxyregistry
  image_name=gomods/athens/proxy
  image_tag=latest

  az acr create \
      --name ${registry_name} --resource-group ${group_name} \
      --sku 'Standard' --admin-enabled 'true' --location westus2
  registry_prefix=$(az acr show \
      --name ${registry_name} --resource-group ${group_name} --output tsv --query 'loginServer')
  registry_password=$(az acr credential show \
      --name ${registry_name} --output tsv --query 'passwords[0].value')
  registry_username=$(az acr credential show \
      --name ${registry_name} --output tsv --query 'username')
  image_uri=${registry_prefix}/${image_name}:${image_tag}
  ```

2. Build images for the proxy and module registry and store in your image registry.

  ```bash
  git clone https://github.com/gomods/athens ./deps/athens
  dockerfile_relative_path=cmd/proxy/Dockerfile
  docker_context_path=deps/athens
  az acr build \
     --registry ${registry_name} \
     --resource-group ${group_name} \
     --file ${dockerfile_relative_path} \
     --image "${image_name}:${image_tag}" \
     ${docker_context_path})

  image_name=gomods/athens/olympus
  dockerfile_relative_path=cmd/olympus/Dockerfile
  docker_context_path=deps/athens
  az acr build \
     --registry ${registry_name} \
     --resource-group ${group_name} \
     --file ${dockerfile_relative_path} \
     --image "${image_name}:${image_tag}" \
     ${docker_context_path})
  ```

3. Create and configure web apps to run these images.

  ```bash
  app_name=<your_name>-go-proxy-app
  plan_name=go-proxy-plan

  az appservice plan create \
    --name ${plan_name} \
    --resource-group ${group_name} \
    --is-linux \
    --location westus2

  az webapp create \
    --name ${app_name} \
    --plan ${plan_name} \
    --resource-group ${group_name} \
    --deployment-container-image-name ${image_uri}
  az webapp config container set --name ${app_name} --resource-group ${group_name} \
    --docker-custom-image-name ${image_uri} \
    --docker-registry-server-url "https://${registry_prefix}" \
    --docker-registry-server-user ${registry_username} \
    --docker-registry-server-password ${registry_password}
  az webapp deployment container config --name ${app_name} --resource-group ${group_name} \
    --enable-cd 'true'
  az webapp log config --name ${app_name} --resource-group ${group_name} \
    --docker-container-logging filesystem \
    --level verbose
  az webapp config appsettings set --name ${app_name} --resource-group ${group_name} \
    --settings "WEBSITE_HTTPLOGGING_RETENTION_DAYS=7"

  app_name=<your_name>-go-olympus-app
  image_name=gomods/athens/olympus
  image_uri=${registry_prefix}/${image_name}:${image_tag}
  az webapp create \
    --name ${app_name} \
    --plan ${plan_name} \
    --resource-group ${group_name} \
    --deployment-container-image-name ${image_uri}
  az webapp config container set --name ${app_name} --resource-group ${group_name} \
    --docker-custom-image-name ${image_uri} \
    --docker-registry-server-url "https://${registry_prefix}" \
    --docker-registry-server-user ${registry_username} \
    --docker-registry-server-password ${registry_password}
  az webapp deployment container config --name ${app_name} --resource-group ${group_name} \
    --enable-cd 'true'
  az webapp log config --name ${app_name} --resource-group ${group_name} \
    --docker-container-logging filesystem \
    --level verbose
  az webapp config appsettings set --name ${app_name} --resource-group ${group_name} \
    --settings "WEBSITE_HTTPLOGGING_RETENTION_DAYS=7"
  ```

4. Setup a CosmosDB/MongoDB account, database, and collection, and get
   connection metadata for later use.

  ```bash
  cosmosdb_account_name=go-proxy-cosmosdb
  db_name=athens
  coll_name=modules

  az cosmosdb create \
    --name ${cosmosdb_account_name} \
    --resource-group ${group_name} \
    --kind MongoDB
  az cosmosdb database create \
    --db-name $db_name --name ${cosmosdb_account_name} --resource-group-name ${group_name}
  az cosmosdb collection create \
	--collection-name $coll_name \
    --db-name $db_name --name ${cosmosdb_account_name} --resource-group-name ${group_name}
  mongo_url=$(az cosmosdb list-connection-strings \
    --name ${cosmosdb_account_name} --resource-group ${group_name} \
    --query "connectionStrings[0].connectionString" --output tsv)
```

5. Configure web app with Mongo connection strings.

  ```
  webapp_id=$(az webapp show --name ${app_name} --resource-group ${group_name} --output tsv --query id)
  url_suffix=azurewebsites.net
  olympus_endpoint=https://go-proxy-olympus-webapp.${url_suffix}
  az webapp config appsettings set --ids $webapp_id \
      --settings \
          "ATHENS_STORAGE_TYPE=mongo" \
          "ATHENS_MONGO_CONNECTION_STRING=${mongo_url}" \
          "OLYMPUS_GLOBAL_ENDPOINT=${olympus_endpoint}"

  app_name=<your_name>-go-olympus-app
  webapp_id=$(az webapp show --name ${app_name} --resource-group ${group_name} --output tsv --query id)
  az webapp config appsettings set --ids $webapp_id \
      --settings \
          "ATHENS_STORAGE_TYPE=mongo" \
          "ATHENS_MONGO_CONNECTION_STRING=${mongo_url}" \
  ```

7. Try it!


* Browse <https://${AZURE_BASE_NAME}.azurewebsites.net/github.com/!azure/azure-sdk-for-go/@v/list>
* Browse <https://${AZURE_BASE_NAME}-webapp.azurewebsites.net/github.com/!azure/azure-sdk-for-go/@v/v19.1.0.zip>
* In a terminal, with Go 1.11+:

  ```bash
  git clone https://github.com/joshgav/go-sample
  cd go-sample
  GOPROXY=https://${AZURE_BASE_NAME}-webapp.azurewebsites.net GO111MODULE=on go get
  ```

This will update dependencies via the specified proxy and create `go.mod` and `go.sum` files.

8. Challenge: Enable the worker and use a Redis queue to manage jobs.
9. Challenge: Enable authentication.
