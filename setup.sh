#!/bin/bash

sudo apt update && sudo apt upgrade -y

# Utils (needs to run before the other scripts, installs curl, wget, etc)
source ./install/install-utils.sh

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
