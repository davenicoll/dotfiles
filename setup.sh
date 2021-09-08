#!/bin/bash

# Ask for auth...
sudo -v

# Keep-alive: update existing sudo time stamp if set, otherwise do nothing.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo apt update && sudo apt upgrade -y

# Utils (needs to run before the other scripts, installs curl, wget, etc)
source ./install/install-utils.sh

exit

# Cloud tools
source ./install/install-awscli.sh
source ./install/install-azcli.sh

# Package managers
source ./install/install-brew.sh

# Apps
source ./install/install-gitkraken.sh
source ./install/install-powershell.sh
source ./install/install-vscode.sh
#source ./install/install-zsh.sh

# Gnome
source ./gnome/settings.sh
source ./gnome/install-extensions.sh

#ln -sf "$PWD/.bashrc" "$HOME/.bashrc"
#ln -sf "$PWD/.dircolors" "$HOME/.dircolors"
#ln -sf "$PWD/.inputrc" "$HOME/.inputrc"
#ln -sf "$PWD/.profile" "$HOME/.profile"
