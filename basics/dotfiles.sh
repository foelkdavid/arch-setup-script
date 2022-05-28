#!/bin/sh
sudo xbps-install -Sy dunst picom rofi sxhkd

sudo xbps-install -Sy neofetch htop cpupower || exit
pip install wheel || exit
pip install s-tui || exit

git clone https://github.com/foelkdavid/dotfiles /tmp/dotfiles
cd /tmp/dotfiles
/tmp/dotfiles/deploy.sh