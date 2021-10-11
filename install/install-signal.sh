#!/bin/bash

if ! command -v signal-desktop &> /dev/null; then
    if [ ! -f /usr/share/keyrings/signal-desktop-keyring.gpg ]; then
        wget -q -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
        cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
        echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
        rm signal-desktop-keyring.gpg
    fi
    sudo apt update -y -qq && sudo apt install signal-desktop -y -qq
else
    echo "signal already installed"
fi
