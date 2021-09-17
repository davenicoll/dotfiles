#!/bin/bash

if ! command -v gitkraken &> /dev/null; then
    curl -o gitkraken.deb -L "https://release.gitkraken.com/linux/gitkraken-amd64.deb"
    sudo dpkg -i gitkraken.deb
    rm gitkraken.deb
else
    echo "VS Code already installed"
    gitkraken -v
fi