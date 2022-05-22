#!/bin/sh
echo "START, please wait..."       
# sudo ln -s /etc/sv/dhcpcd /var/service
# sudo sv start dhcpcd
# sleep 5
sudo xbps-install -Syu git 

chmod +x $PWD/add-ons/*
$PWD/add-ons/zsh.sh
$PWD/add-ons/nvim.sh
$PWD/add-ons/basics.sh
$PWD/add-ons/sources.sh
$PWD/add-ons/xorg.sh
$PWD/add-ons/applications.sh
$PWD/add-ons/cleanup.sh