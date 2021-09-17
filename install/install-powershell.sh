#!/bin/bash

if ! command -v pwsh &> /dev/null; then
    sudo apt-get update -qq
    sudo apt-get install -qq -y wget apt-transport-https software-properties-common
    wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo apt-get update -qq
    sudo add-apt-repository -y universe
    sudo apt-get install -qq -y powershell
    rm packages-microsoft-prod.deb
else
    echo "Powershell already installed"
    pwsh --version
fi