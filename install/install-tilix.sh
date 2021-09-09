#!/bin/bash

if [ $(which tilix | grep 'bin' | wc -l) -eq 0 ]; then
    sudo apt install tilix -qq -y
    # Configure tilix
    tee -a ./tilix.config &>/dev/null << EOF
[/]
enable-wide-handle=false
sidebar-on-right=false
terminal-title-show-when-single=false
terminal-title-style='normal'
use-tabs=true
warn-vte-config-issue=false
window-style='normal'

[profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d]
background-color='#2C2C2C2C2C2C'
background-transparency-percent=7
cursor-blink-mode='on'
dim-transparency-percent=0
font='JetBrains Mono 12'
foreground-color='#D3D3D7D7CFCF'
palette=['#2A2A28282828', '#FFFF51515151', '#C2C2D8D82B2B', '#FFFFC1C13535', '#4242A4A4F5F5', '#D8D81B1B5F5F', '#0000ACACC1C1', '#F5F5F5F5F5F5', '#707082828484', '#FFFF51515151', '#C2C2D8D82B2B', '#FFFFC1C13535', '#4242A4A4F5F5', '#D8D81B1B5F5F', '#0000ACACC1C1', '#EEEEEEEEECEC']
scrollback-lines=20000
use-system-font=false
use-theme-colors=false
visible-name='Default'
EOF
    dconf load /com/gexperts/Tilix/ < ./tilix.config
    rm ./tilix.config
else
    echo "tilix already installed"
    tilix --version
fi