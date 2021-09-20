#!/bin/bash

if ! command -v aws &> /dev/null; then
    sudo apt install awscli -qq -y
else
    echo "aws already installed"
    aws --version
fi