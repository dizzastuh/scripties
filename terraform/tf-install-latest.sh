#!/bin/bash

source utils.sh

#######################################################
#################     EXECUTIONS     ##################
#######################################################

TF_ZIP="tf.zip"
TERRAFORM_DIR="/usr/local/bin/"
TERRAFORM_FILE="${TERRAFORM_DIR}/terraform"


# original jq found here as a cute one-liner: https://github.com/hashicorp/terraform/issues/9803#issuecomment-257903082
echo "Retrieving download url..."

curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r '. as $obj | "\($obj.current_download_url) \($obj.current_version)"' | while read latest_url latest_version; do
  validate_val "latest download url" $latest_url
  validate_val "latest version" $latest_version
  
  FILE_NAME="terraform_${latest_version}_linux_amd64.zip"
  FILE_URL="${latest_url}${FILE_NAME}"
done

echo $FILE_URL
echo ""

# download the file
echo "Downloading File..."
curl $FILE_URL --output $TF_ZIP
echo "Done.  Validating file download.."

validate_file $TF_ZIP


# clean out existing terraform files
echo "Checking for exsisting installations of terraform..."
if [ -f $TERRAFORM_FILE ]; then
  echo "Existing version found:"
  terraform --version
  echo "Removing..."
  sudo rm $TERRAFORM_FILE
else
  echo "No existing version found. Continuing."
fi


# extract the file
echo "Extracting zip file..."
sudo unzip $TF_ZIP -d $TERRAFORM_DIR

# check that the file exists
validate_file $TERRAFORM_FILE

echo "Install complete.  Validating installation..."

terraform --version

echo "Performing cleanup..."
rm $TF_ZIP

echo "Done."
echo ""
