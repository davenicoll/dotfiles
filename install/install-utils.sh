#!/bin/bash

sudo apt install curl figlet lolcat wget exa git neofetch xclip shellcheck p7zip-full tilix build-essential silversearcher-ag fzf jq ffmpeg flameshot gnome-shell-extension-prefs -y

# configure print screen to trigger flameshot
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "'Flameshot'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "'Print'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "'flameshot gui'"

# configure flameshot settings
if ! test -d "$HOME/.config/flameshot/"; then mkdir $HOME/.config/flameshot; fi
if test -f "$HOME/.config/flameshot/flameshot.ini"; then rm "$HOME/.config/flameshot/flameshot.ini"; fi
tee -a $HOME/.config/flameshot/flameshot.ini << EOL
[General]
contrastUiColor=#bf1c00
disabledTrayIcon=false
drawColor=#ff0000
drawThickness=0
saveAfterCopyPath=$HOME/Pictures
showHelp=false
startupLaunch=true
uiColor=#ff5100
EOL