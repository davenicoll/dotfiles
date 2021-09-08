#!/bin/bash

if [ $(which flameshot | grep 'bin' | wc -l) -eq 0 ]; then
    sudo apt install flameshot -y -qq

    # configure print screen to trigger flameshot
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "'Flameshot'"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "'Print'"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "'flameshot gui'"

    # configure flameshot settings
    if ! test -d "$HOME/.config/flameshot/"; then mkdir "$HOME/.config/flameshot"; fi
    if test -f "$HOME/.config/flameshot/flameshot.ini"; then rm "$HOME/.config/flameshot/flameshot.ini"; fi
    tee -a "$HOME/.config/flameshot/flameshot.ini" &>/dev/null << EOF
[General]
contrastUiColor=#bf1c00
disabledTrayIcon=false
drawColor=#ff0000
drawThickness=0
saveAfterCopyPath=$HOME/Pictures
showHelp=false
startupLaunch=true
uiColor=#ff5100
EOF
else
    echo "flameshot already installed"
    flameshot --version
fi