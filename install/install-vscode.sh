#!/bin/bash

if ! command -v code &> /dev/null; then
    curl --silent -o vscode.deb -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    sudo dpkg -i vscode.deb
    rm vscode.deb
else
    echo "VS Code already installed"
    code -v
fi
