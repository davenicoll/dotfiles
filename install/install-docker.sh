#!/bin/bash

if [ $(which docker | grep 'bin' | wc -l) -eq 0 ]; then
    # use docker convenience installer
    curl -fsSL https://get.docker.com -o get-docker.sh
    chmod +x ./get-docker.sh
    sudo sh ./get-docker.sh
    rm ./get-docker.sh
else
    echo "docker already installed"
    docker version
fi