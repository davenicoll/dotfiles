#!/bin/bash

if [ $(which aws | grep 'bin' | wc -l) -eq 0 ]; then
    sudo apt install awscli -qq -y
else
    echo "aws already installed"
    aws --version
fi