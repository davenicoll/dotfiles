#!/bin/bash

# install gnome extensions (use the gnome shell extension installer to get the latest version of extensions)
curl -o gnome-shell-extension-installer.sh -L https://raw.githubusercontent.com/brunelli/gnome-shell-extension-installer/master/gnome-shell-extension-installer
chmod +x gnome-shell-extension-installer.sh

./gnome-shell-extension-installer.sh 779 # 779 - clipboard indicator
./gnome-shell-extension-installer.sh 906 # 906 - sound input & output device chooser
./gnome-shell-extension-installer.sh 708 # 708 - Panel OSD
./gnome-shell-extension-installer.sh 800 # 800 - remove dropdown arrows
./gnome-shell-extension-installer.sh 355 # 355 - status area horizontal spacing
./gnome-shell-extension-installer.sh 1007 # 1007 - window is ready - notification remover
./gnome-shell-extension-installer.sh 2 # 2 - frippery move clock

# get all of the extension UUIDs and enable them
for item in $(ls -1 $HOME/.local/share/gnome-shell/extensions)
do
    extensions=("'$item',$extensions")
done
gsettings set org.gnome.shell enabled-extensions "[${extensions::-1}]"

echo "****************************************************************"
echo "You'll need to logout and log back in to enable gnome extensions"
echo "****************************************************************"