1. Install az-cli, per
   <https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt>. For
   other OS's, see
   <https://docs.microsoft.com/en-us/cli/azure/install-azure-cli>.

    ```
    codename=$(lsb_release -cs)
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $codename main" | \
        sudo tee /etc/apt/sources.list.d/azure-cli.list
    curl -L https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    sudo apt-get install apt-transport-https
    sudo apt-get update && sudo apt-get install azure-cli
    ```

1. Login: `az login`. Use the username and password given to you.

1. Verify your account details: `az account show`.

1. Find the resource group precreated for you: `az group list`.

1. Prefer your own account? Set one up for free at <https://azure.microsoft.com/free/>.
