#!/bin/bash

if [ "$(which spotify | grep -c 'bin')" -eq 0 ]; then
    curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get -qq update && sudo apt-get -qq -y install spotify-client
else
    echo "Spotify already installed"
    spotify --version
fi