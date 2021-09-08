#!/bin/bash

if [ $(which tilix | grep 'bin' | wc -l) -eq 0 ]; then
    sudo apt install tilix -qq -y
    #TODO: customizations go here
else
    echo "tilix already installed"
    tilix --version
fi