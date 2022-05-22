#!/bin/sh
sudo xbps-install -Sy dunst picom rofi sxhkd sxhkd

git clone https://github.com/foelkdavid/dotfiles /tmp/dotfiles
cd /tmp/dotfiles
/tmp/dotfiles/deploy.sh