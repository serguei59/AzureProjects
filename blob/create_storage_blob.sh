
# execute: bash create_storage_blob.sh
#load environment variables from .env file
set -o allexport
source .env
set +o allexport

#create new resource group
az group create \
    --name $STORAGE_RESOURCE_GROUP \
    --location $LOCATION

# create storage account
az storage account create \
    --name $STORAGE_ACCOUNT \
    --resource-group $STORAGE_RESOURCE_GROUP \
    --location $LOCATION \
    --access-tier Cool \
    --sku Standard_LRS 
    
# recuperer la clé de stockage 
STORAGE_KEY=$(az storage account keys list --resource-group $STORAGE_RESOURCE_GROUP \
    --account-name $STORAGE_ACCOUNT \
    --query '[0].value'\
    --output tsv \
)
# create a blob container
az storage container create \
    --name $CONTAINER_NAME \
    --account-name $STORAGE_ACCOUNT \
    --account-key $STORAGE_KEY

# Ecrire la cle de stockage dans le fichier .env
echo "STORAGE_KEY='$STORAGE_KEY'" >> .env
echo "Storage key: $STORAGE_KEY"