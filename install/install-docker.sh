#!/bin/bash

if ! command -v docker &> /dev/null; then
    # use docker convenience installer
    sudo apt install uidmap --q -y
    curl -fsSL https://get.docker.com -o get-docker.sh
    chmod +x ./get-docker.sh
    sudo sh ./get-docker.sh
    rm ./get-docker.sh
    
    # Setup docker for rootless use
    dockerd-rootless-setuptool.sh install
    sudo usermod -aG docker "${USER}"
    sudo systemctl start docker
else
    echo "docker already installed"
    docker version
fi