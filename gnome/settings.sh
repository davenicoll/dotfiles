#!/bin/bash
# Gnome settings

gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchpad edge-scrolling-enabled false
gsettings set org.gnome.desktop.peripherals.touchpad two-finger-scrolling-enabled true
gsettings set org.gnome.desktop.peripherals.touchpad scroll-method 'two-finger-scrolling'
gsettings set org.gnome.desktop.peripherals.touchpad click-method fingers

gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface font-name 'SF Pro Display 11'
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

tee ./panel-osd.config &>/dev/null << EOF
[/]
test-notification=false
x-pos=98.900000000000006
y-pos=98.200000000000003
EOF
dconf load /org/gnome/shell/extensions/panel-osd/ < ./panel-osd.config
rm ./panel-osd.config

# set users profile picture
username="$(whoami)"
sudo tee /var/lib/AccountsService/users/dave &>/dev/null << EOF
[User]
Session=
XSession=
Icon=/var/lib/AccountsService/icons/$username
SystemAccount=false

[InputSource0]
xkb=gb
EOF
sudo cp ./images/fe.png "/var/lib/AccountsService/icons/$username"

# set users background wallpaper
gsettings set org.gnome.desktop.background picture-uri "file:///$HOME/.dotfiles/images/macOS.jpg"
gsettings set org.gnome.desktop.background picture-options 'zoom'