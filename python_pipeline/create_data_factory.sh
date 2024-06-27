#load environment variables from .env file
set -o allexport
source .env
set +o allexport

#create resource group
az group create --name $RESOURCE_GROUP  --location $LOCATION

#create storage account
az storage account create --resource-group $RESOURCE_GROUP \
    --name $STORAGE_ACCOUNT \
    --location $LOCATION \
    --access-tier Cool \
    --sku Standard_LRS

#blob container creation
##recover storage key
STORAGE_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP \
    --account-name $STORAGE_ACCOUNT \
    --query '[0].value' \
    --output tsv \
)
##create a blob container 
az storage container create --resource-group $RESOURCE_GROUP \
    --name $CONTAINER_NAME \
    --account-name $STORAGE_ACCOUNT \
    --account-key $STORAGE_KEY
##write the storage key inside .env file
echo "STORAGE_KEY='$STORAGE_KEY'" >> .env
echo "Storage key: $STORAGE_KEY"

#upload d'un file dans le container
#Variables
FILE_PATH="/home/apprenant/PythonProjets/AzureProjects/blob/script.py"
BLOB_NAME="script.py"

#upload d'un file dans le container
az storage blob upload \
    --account-name $STORAGE_ACCOUNT \
    --account-key $STORAGE_KEY \
    --container-name $CONTAINER_NAME \
    --name $BLOB_NAME \
    --file $FILE_PATH

# data factory creation
az datafactory create --resource-group  $RESOURCE_GROUP \
    --factory-name $DATA_FACTORY_NAME \
    --location $LOCATION
