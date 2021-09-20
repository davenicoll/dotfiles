#!/bin/bash
# Should be run as sudo or with appropriate permissions to install the terraform binary

INSTALL_LOCATION="/usr/bin"
if [[ "$OSTYPE" == "darwin"* ]]; then INSTALL_LOCATION="/usr/local/bin"; fi
TEMP_LOCATION="/tmp"

ARCHITECTURE=""
case $(uname -m) in
    i386)   ARCHITECTURE="386" ;;
    i686)   ARCHITECTURE="386" ;;
    x86_64) ARCHITECTURE="amd64" ;;
    arm)    dpkg --print-architecture | grep -q "arm64" && ARCHITECTURE="arm64" || ARCHITECTURE="arm" ;;
esac
OS=$(uname | tr '[:upper:]' '[:lower:]')

# Determine latest version
TF_LATEST_VERSION=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/hashicorp/terraform/releases/latest | awk -F / '{print substr($NF,2);}')

# Manual override
#TF_LATEST_VERSION="0.1.6"

# Determine installed version
if ! command -v terraform &> /dev/null; then
    TF_CURRENT_VERSION=""
else
    TF_CURRENT_VERSION=$(terraform --version | head -n +1 | awk -F Terraform '{print substr($NF,3);}')
fi

function download_and_install()
{
    rm -f "$TEMP_LOCATION/terraform*" 2> /dev/null
    DOWNLOAD_URI="https://releases.hashicorp.com/terraform/${TF_LATEST_VERSION}/terraform_${TF_LATEST_VERSION}_${OS}_${ARCHITECTURE}.zip"
    echo "Downloading $DOWNLOAD_URI"
    wget -q "$DOWNLOAD_URI" -O "$TEMP_LOCATION/terraform.zip" 2>&1 
    if [ ! -f "$TEMP_LOCATION/terraform.zip" ] || [ ! -s "$TEMP_LOCATION/terraform.zip" ]; then
        echo "ERROR: Download failed"
        exit 1
    fi
    unzip -o -q "$TEMP_LOCATION/terraform.zip" -d "$TEMP_LOCATION" 2>&1 
    rm -f "$TEMP_LOCATION/terraform.zip"
    sudo mv -f "$TEMP_LOCATION/terraform" "$INSTALL_LOCATION/terraform"
}

if [ -z "$TF_CURRENT_VERSION" ]; then
    echo "Installing terraform $TF_LATEST_VERSION"
    download_and_install
elif [ "$TF_LATEST_VERSION" != "$TF_CURRENT_VERSION" ]; then
    echo "Upgrading terraform $TF_CURRENT_VERSION to $TF_LATEST_VERSION"
    download_and_install
else
    echo "Terraform already installed"
    terraform --version
fi
