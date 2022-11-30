#!/bin/sh
sudo pacman -S --noconfirm dunst picom rofi sxhkd

sudo pacman -S --noconfirm neofetch htop cpupower || exit
pip install wheel || exit
pip install s-tui || exit

git clone https://github.com/foelkdavid/dotfiles /tmp/dotfiles
cd /tmp/dotfiles
/tmp/dotfiles/deploy.sh