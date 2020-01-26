#######################################################
##################     FUNCTIONS     ##################
#######################################################

function validate_file() {
  local file=$1
  
  if [ ! -f $file ]; then
    echo "No file $file found.  Exiting."
  fi  
}

function validate_val() {
  local $val=$1

  if [ -z "$val" ] || [ "$val" == "null" ] ; then
    echo "Value was empty or null.  Exiting."
  fi
}

#######################################################
#################     EXECUTIONS     ##################
#######################################################

TF_ZIP="tf.zip"
TERRAFORM_DIR="/usr/local/bin/"
TERRAFORM_FILE="${TERRAFORM_DIR}/terraform"


echo "Retrieving download url..."
FILE_URL=`echo "https://releases.hashicorp.com/terraform/$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M '.current_version')/terraform_$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M '.current_version')_linux_amd64.zip"`

validate_val $FILE_URL

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

validate_file $TERRAFORM_FILE

echo "Script completing.  Running `terraform --version` to validate installation..."

terraform --version
