#!/bin/bash
# Gnome settings

# Touchpad
dconf write /org/gnome/desktop/peripherals/touchpad/natural-scroll false
dconf write /org/gnome/desktop/peripherals/touchpad/tap-to-click true
dconf write /org/gnome/desktop/peripherals/touchpad/edge-scrolling-enabled false
dconf write /org/gnome/desktop/peripherals/touchpad/two-finger-scrolling-enabled true
dconf write /org/gnome/desktop/peripherals/touchpad/click-method "'fingers'"

# Appearance / Fonts
dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita-dark'"
dconf write /org/gnome/desktop/interface/font-name "'SF Pro Display 11'"
dconf write /org/gnome/desktop/wm/preferences/titlebar-font "'SF Pro Display 11'"
dconf write /org/gnome/desktop/interface/document-font-name "'SF Pro Display 11'"
dconf write /org/gnome/desktop/interface/monospace-font-name "'JetBrains Mono 11'"

# Dash to Dock
dconf write /org/gnome/shell/extensions/dash-to-dock/dock-position "'BOTTOM'"
dconf write /org/gnome/shell/extensions/dash-to-dock/dash-max-icon-size 24
dconf write /org/gnome/shell/extensions/dash-to-dock/extend-height false
dconf write /org/gnome/shell/extensions/dash-to-dock/transparency-mode "'FIXED'"
dconf write /org/gnome/shell/extensions/dash-to-dock/background-opacity 0.2
dconf write /org/gnome/shell/extensions/dash-to-dock/click-action "'minimize-or-previews'"
dconf write /org/gnome/shell/extensions/dash-to-dock/running-indicator-style "'SEGMENTED'"
dconf write /org/gnome/shell/extensions/dash-to-dock/show-show-apps-button false
dconf write /org/gnome/shell/extensions/dash-to-dock/force-straight-corner true
dconf write /org/gnome/shell/extensions/dash-to-dock/running-indicator-dominant-color true

# Window Manager
dconf write /org/gnome/desktop/wm/preferences/button-layout "'close,minimize,maximize:'"

# Desktop Icons (DING) — only works if extension is installed
dconf write /org/gnome/shell/extensions/ding/show-trash false
#dconf write /org/gnome/shell/extensions/ding/show-home false
#dconf write /org/gnome/shell/extensions/ding/show-volumes false

# File Chooser
dconf write /org/gtk/settings/file-chooser/show-hidden true


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
sudo tee /var/lib/AccountsService/users/${username} &>/dev/null << EOF
[User]
Session=
XSession=
Icon=/var/lib/AccountsService/icons/$username
SystemAccount=false

[InputSource0]
xkb=gb
EOF
sudo chmod uga+r /var/lib/AccountsService/users/${username}
sudo cp ./images/fe.png "/var/lib/AccountsService/icons/$username"

# set users background wallpaper
gsettings set org.gnome.desktop.background picture-uri "file:///$HOME/.dotfiles/images/macOS.jpg"
gsettings set org.gnome.desktop.background picture-options 'zoom'
