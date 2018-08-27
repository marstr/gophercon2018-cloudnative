#!/usr/bin/env bash

set -o errexit
set -o allexport
__dirname=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
__root=${__dirname}
if [[ -f "${__root}/.env" ]]; then source "${__root}/.env"; fi
set +o allexport

function ensure_group () {
    local group_name=$1
    local group_id

    group_id=$(az group show --name $group_name --query 'id' --output tsv 2> /dev/null)

    if [[ -z $group_id ]]; then
        group_id=$(az group create \
            --name $group_name \
            --location $location \
            --query 'id' --output tsv)
    fi
    echo $group_id
}

# setup supporting services
bash "${__root}/setup_infra.sh"

# setup proxy
bash "${__root}/setup_app.sh" \
    gomods/athens/proxy dev \
    no_cd \
    update_submodules_first \
    "https://github.com/gomods/athens.git" \
    proxy
bash "${__root}/configure_app.sh" proxy

# setup olympus
bash "${__root}/setup_app.sh" \
    gomods/athens/olympus dev \
    no_cd \
    update_submodules_first \
    "https://github.com/gomods/athens.git" \
    olympus
bash "${__root}/configure_app.sh" olympus

