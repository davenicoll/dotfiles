#!/bin/bash

if [ $(az --version 2>/dev/null | grep 'azure-cli' | wc -l) -eq 0 ]; then
    sudo apt-get update
    sudo apt-get install ca-certificates curl apt-transport-https lsb-release gnupg -y
    curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
    AZ_REPO=$(lsb_release -cs)
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
    sudo apt-get update
    sudo apt-get install azure-cli -y
else
    echo "az already installed"
    az --version | head -n 1
fi