#!/bin/bash

if [ $(which code | grep 'bin' | wc -l) -eq 0 ]; then
    curl -o vscode.deb -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    sudo dpkg -i vscode.deb
    rm vscode.deb
else
    echo "VS Code already installed"
    code -v
fi