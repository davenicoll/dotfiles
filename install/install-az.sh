#!/bin/bash

if ! command -v az &> /dev/null; then
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
else
    echo "az already installed"
    az --version | head -n 1
fi
