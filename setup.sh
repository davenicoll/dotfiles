#!/bin/bash

sudo apt update && sudo apt upgrade -y

# standard toolchain
sudo apt install curl wget exa git neofetch p7zip-full tilix build-essential silversearcher-ag fzf jq ffmpeg gnome-shell-extension-prefs zsh -y

# jetbrains mono
# curl -o jetbrainsmono.zip -L "https://github.com/JetBrains/JetBrainsMono/releases/download/v2.242/JetBrainsMono-2.242.zip"
# mkdir "$HOME/.fonts"
# unzip -j jetbrainsmono.zip "fonts/ttf/*" -d "$HOME/.fonts"
# rm jetbrainsmono.zip

# vscode
curl -o vscode.deb -L "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
sudo dpkg -i vscode.deb
rm vscode.deb

# gitkraken
curl -o gitkraken.deb -L "https://release.gitkraken.com/linux/gitkraken-amd64.deb"
sudo dpkg -i gitkraken.deb
rm gitkraken.deb

# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# cloud toolchain

# powershell
sudo apt-get update
sudo apt-get install -y wget apt-transport-https software-properties-common
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo add-apt-repository universe
sudo apt-get install -y powershell

# Gnome tweaks
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface font-name 'SF Pro 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 11'

gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 24
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode FIXED
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style SEGMENTED
gsettings set org.gnome.shell.extensions.dash-to-dock show-show-apps-button false
gsettings set org.gnome.shell.extensions.dash-to-dock force-straight-corner true
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-dominant-color true

gsettings set org.gnome.shell.extensions.ding show-trash false
#gsettings set org.gnome.shell.extensions.ding show-home false
#gsettings set org.gnome.shell.extensions.ding show-volumes false
gsettings set org.gtk.Settings.FileChooser show-hidden true

#ln -sf "$PWD/.bashrc" "$HOME/.bashrc"
#ln -sf "$PWD/.dircolors" "$HOME/.dircolors"
#ln -sf "$PWD/.inputrc" "$HOME/.inputrc"
#ln -sf "$PWD/.profile" "$HOME/.profile"
