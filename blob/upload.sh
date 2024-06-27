#load environment variables from .env file
set -o allexport
source .env
set +o allexport

# Variables
FILE_PATH="/home/apprenant/PythonProjets/AzureProjects/blob/script.py"
BLOB_NAME="script.py"

#upload
az storage blob upload \
    --account-name $STORAGE_ACCOUNT \
    --account-key $STORAGE_KEY \
    --container-name $CONTAINER_NAME \
    --name $BLOB_NAME \
    --file $FILE_PATH