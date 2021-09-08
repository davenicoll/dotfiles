#!/bin/bash

curl -o gitkraken.deb -L "https://release.gitkraken.com/linux/gitkraken-amd64.deb"
sudo dpkg -i gitkraken.deb
rm gitkraken.deb