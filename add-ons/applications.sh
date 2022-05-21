#!/bin/sh
sudo xbps-install -Sy dunst picom rofi sxhkd

git clone https://github.com/foelkdavid/dotfiles /tmp/
cd /tmp/dotfiles
/tmp/dotfiles/deploy.sh