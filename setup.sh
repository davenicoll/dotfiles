#!/bin/bash

# Symlink dotfiles
ln -sf "$PWD/.aliases" "$HOME/.aliases"
ln -sf "$PWD/.bash_prompt" "$HOME/.bash_prompt"
ln -sf "$PWD/.bashrc" "$HOME/.bashrc"
#ln -sf "$PWD/.dircolors" "$HOME/.dircolors"
ln -sf "$PWD/.exports" "$HOME/.exports"
ln -sf "$PWD/.functions" "$HOME/.functions"
#ln -sf "$PWD/.inputrc" "$HOME/.inputrc"
ln -sf "$PWD/.path" "$HOME/.path"
ln -sf "$PWD/.profile" "$HOME/.profile"

# Install fonts
if ! test -d "$HOME/.fonts/"; then mkdir "$HOME/.fonts"; fi
cp ./.fonts/* ~/.fonts/

# Ask for auth...
sudo -v

# Keep-alive: update existing sudo time stamp if set, otherwise do nothing.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo apt update -qq && sudo apt upgrade -y -qq

# Utils (needs to run before the other scripts, installs curl, wget, etc)
source ./install/install-utils.sh

# Cloud tools
source ./install/install-aws.sh
source ./install/install-az.sh
source ./install/install-terraform.sh

# Package managers
source ./install/install-brew.sh

# Apps
source ./install/install-flameshot.sh
source ./install/install-gitkraken.sh
source ./install/install-powershell.sh
source ./install/install-tilix.sh
source ./install/install-vscode.sh
#source ./install/install-zsh.sh

# Gnome
source ./gnome/settings.sh
source ./gnome/install-extensions.sh
