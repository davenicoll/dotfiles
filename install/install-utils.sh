#!/bin/bash

# pre-accept the ttf-mscorefonts-installer eula
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
echo ttf-mscorefonts-installer msttcorefonts/present-mscorefonts-eula note | sudo debconf-set-selections

sudo apt install curl figlet lolcat wget exa git neofetch xclip nmap htop shellcheck obs-studio p7zip-full unzip file build-essential silversearcher-ag fzf jq ffmpeg gnome-shell-extension-prefs ttf-mscorefonts-installer -y -qq
