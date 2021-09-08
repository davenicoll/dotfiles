#!/bin/bash
# Gnome settings

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