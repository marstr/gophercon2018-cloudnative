#!/usr/bin/env bash

######
# setup_app.sh
#
# Sets up infrastructure for a continuously-built and deployed container-based
# web app for Azure App Service.
#
# $1: image_name: Name of image (aka repo) to use or create. Defaults to
#     $IMAGE_NAME.
# $2: image_tag: Name of image tag. Defaults to $IMAGE_TAG
# $3: no_cd: don't continuously deploy from repo even if public
# $4: update_submodules_first: `git submodule update --init`
# $5: repo_url: Source code repo to use for continuous build. Defaults to
#     "https://github.com/{IMAGE_NAME}.git"
# $6: athens_service: "proxy" or "olympus"
# 
# $7: base_name: A default prefix for all Azure resources. Defaults to $AZURE_BASE_NAME.
# $8: app_name: Name of App Service web app to use or create. Defaults to
#     "{AZURE_BASE_NAME}-webapp".
# $9: registry_name: Name of Azure container registry to use or create.
#     Defaults to "${AZURE_BASE_NAME}-registry".
# $10: plan_name: Name of App Service plan to use or create. Defaults to
#     "{AZURE_BASE_NAME}-plan".
# $11: group_name: Name of Azure resource group to use for all resources.
#     Defaults to "${AZURE_BASE_NAME-group".
# location: Name of Azure location to use for all resources. Defaults to
#     $AZURE_DEFAULT_LOCATION.
#####

__dirname=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

image_name=${1:-${IMAGE_NAME}}
image_tag=${2:-${IMAGE_TAG}}
no_cd=${3:-true}
update_submodules_first=${4:-true}
repo_url=${5:-"https://github.com/${image_name}.git"}
athens_service=${6:-"proxy"} # or "olympus", determines which Dockerfile to reference

base_name=${7:-"${AZURE_BASE_NAME}"}
app_name=${8:-"${base_name}-${athens_service}-webapp"}

registry_name=${9:-"$(echo ${base_name} | sed 's/[- _]//g')registry"}
plan_name=${10:-"${base_name}-plan"}
group_name=${11:-"${base_name}-group"}
location=${AZURE_DEFAULT_LOCATION}
# note: $GH_TOKEN used in CD setup

# set after getting registry config
image_uri=
registry_sku=Standard
url_suffix=azurewebsites.net

# errors
declare -i err_registrynameexists=101
declare -i err_nogithubtoken=102

####

if [[ "$update_submodules_first" == "true" ]]; then
    git submodule update --init
fi

## ensure groups
ensure_group $group_name

## ensure registry
registry_id=$(az acr show \
        --name ${registry_name} --resource-group ${group_name} \
        --output tsv --query 'id' 2> /dev/null)
if [[ -z "${registry_id}" ]]; then
    namecheck_results=$(az acr check-name --name ${registry_name} \
        --output tsv --query '[nameAvailable, reason]')
    name_available=$(echo $namecheck_results | cut -d " " -f1)
    reason=$(echo $namecheck_results | cut -d " " -f2)
    if [[ "false" == "${name_available}" ]]; then
        echo "registry name [${registry_name}] unavailable, reason [${reason}]"
        exit $err_registrynameexists
    fi

    registry_id=$(az acr create \
        --name ${registry_name} \
        --resource-group ${group_name} \
        --sku ${registry_sku} \
        --admin-enabled 'true' \
        --location $location \
        --output tsv --query id)
fi
registry_prefix=$(az acr show \
    --name ${registry_name} --resource-group ${group_name} --output tsv --query 'loginServer')
registry_password=$(az acr credential show \
    --name ${registry_name} --output tsv --query 'passwords[0].value')
registry_username=$(az acr credential show \
    --name ${registry_name} --output tsv --query 'username')
image_uri=${registry_prefix}/${image_name}:${image_tag}
echo "ensured registry: ${registry_id}"
echo "using image_uri: ${image_uri}"

## ensure App Service plan
plan_id=$(az appservice plan show \
    --name ${plan_name} \
    --resource-group ${group_name} \
    --output tsv --query id)
if [[ -z $plan_id ]]; then
    plan_id=$(az appservice plan create \
        --name ${plan_name} \
        --resource-group ${group_name} \
        --location $location \
        --is-linux \
        --output tsv --query id)
fi
echo "ensured plan $plan_id"

## ensure Web App
webapp_id=$(az webapp show \
    --name ${app_name} \
    --resource-group ${group_name} \
    --output tsv --query id 2> /dev/null)
if [[ -z $webapp_id ]]; then
webapp_id=$(az webapp create \
    --name "$app_name" \
    --plan ${plan_id} \
    --resource-group ${group_name} \
    --deployment-container-image-name ${image_uri} \
    --output tsv --query 'id')
fi

# configure web app
webapp_config=$(az webapp config container set \
    --ids $webapp_id \
    --docker-custom-image-name ${image_uri} \
    --docker-registry-server-url "https://${registry_prefix}" \
    --docker-registry-server-user ${registry_username} \
    --docker-registry-server-password ${registry_password} \
    --output json)
webapp_config2=$(az webapp deployment container config \
    --ids $webapp_id \
    --enable-cd 'true' \
    --output json)
webapp_config3=$(az webapp config appsettings set \
    --ids $webapp_id \
    --settings "WEBSITE_HTTPLOGGING_RETENTION_DAYS=7" \
    --output json)
webapp_config4=$(az webapp log config \
    --ids $webapp_id \
    --docker-container-logging filesystem \
    --level verbose)
echo "ensured web app: $webapp_id"

curl -L --fail "${repo_url}" 2> /dev/null 1> /dev/null
curl_exitcode=$?

dockerfile_relative_path=cmd/${athens_service}/Dockerfile
docker_context_path=${repo_url}
if [[ ("$curl_exitcode" == "22") || ("${no_cd}" == "no_cd") ]]; then
    echo "building from local context"
    echo "note: continuous build and deploy requires a hosted repo"
    dockerfile_relative_path=${dockerfile_relative_path}
    docker_context_path=deps/athens
    # run one build and push image
    # add `--no-logs` to suppress log output
    build_id=$(az acr build \
         --registry ${registry_name} \
         --resource-group ${group_name} \
         --file ${dockerfile_relative_path} \
         --image "${image_name}:${image_tag}" \
         --output tsv --query id \
         ${docker_context_path})

else
    echo "using hosted repo: $repo_url for continuous build and deploy"

    if [[ -z ${GH_TOKEN} ]]; then
        echo 'specify a GitHub personal access token in the env var `GH_TOKEN`' \
             'to set up continuous deploy'
        exit $err_nogithubtoken
    fi

    # set up a build task to build on commit
    buildtask_name=buildoncommit
    buildtask_id=$(az acr build-task create \
        --name ${buildtask_name} \
        --registry ${registry_name} \
        --resource-group ${group_name} \
        --context ${repo_url} \
        --git-access-token ${GH_TOKEN} \
        --image "${image_name}:${image_tag}" \
        --branch 'master' \
        --commit-trigger-enabled 'true' \
        --file 'Dockerfile' \
        --output tsv --query id)

    # and run once now
    # add `--no-logs` to suppress log output
    buildtask_run_id=$(az acr build-task run \
        --name ${buildtask_name} \
        --registry ${registry_name} \
        --resource-group ${group_name} \
        --output tsv --query id)
fi

