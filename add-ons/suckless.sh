#!/bin/sh

# get sources
git clone --depth 1 -- https://github.com/foelkdavid/dwmfork /tmp/suckless/dwm
git clone --depth 1 -- https://github.com/foelkdavid/stfork /tmp/suckless/st
git clone --depth 1 -- https://github.com/nsxiv/nsxiv /tmp/suckless/nsxiv
git clone --depth 1 -- https://github.com/torrinfail/dwmblocks /tmp/suckless/dwmblocks

mkdir -p $HOME/.local/src/
mv /tmp/suckless/dwm $HOME/.local/src/dwm
mv /tmp/suckless/dwmblocks $HOME/.local/src/dwmblocks
mv /tmp/suckless/st $HOME/.local/src/st
mv /tmp/suckless/nsxiv$HOME/.local/src/nsxiv
