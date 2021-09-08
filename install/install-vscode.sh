#!/bin/bash

curl -o vscode.deb -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo dpkg -i vscode.deb
rm vscode.deb