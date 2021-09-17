#!/bin/bash

if ! command -v go &> /dev/null; then
    #find the latest version of golang...
    filename=$(curl --silent https://golang.org/dl/?mode=json | jq -rc '[.[].files[] | select(.os=="linux" and .arch=="amd64")][0].filename')
    download_url="https://golang.org/dl/$filename"
    curl -fsSL -o "$filename" "$download_url"
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "$filename"
    #export PATH=$PATH:/usr/local/go/bin #should already be in your dotfiles path ;)
    rm "$filename"
else
    echo "golang already installed"
    go version
fi