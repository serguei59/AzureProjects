#installation azure cli
#taper chmod + x create_resource_group.sh

#load environment variables from .env file
set -o allexport
source .env
set +o allexport

# # # Login
# az login


# az account list --output table


# create new resource group
az group delete --name $RESOURCE_GROUP