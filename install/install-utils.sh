#!/bin/bash

# pre-accept the ttf-mscorefonts-installer eula
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
echo ttf-mscorefonts-installer msttcorefonts/present-mscorefonts-eula note | sudo debconf-set-selections

sudo apt install nano libssl-dev curl figlet lolcat wget eza git neofetch xclip nmap htop shellcheck obs-studio p7zip-full unzip file build-essential silversearcher-ag fzf jq ffmpeg gnome-shell-extension-prefs ttf-mscorefonts-installer zlib1g-dev libreadline-dev libreadline8 sqlite3 libsqlite3-dev libbz2-dev libffi-devel -y -qq
