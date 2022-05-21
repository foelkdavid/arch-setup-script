#!/bin/sh

# get sources
# these are my own forks, using plugins that have to be manually merged.
git clone --depth 1 -- https://github.com/foelkdavid/dwm /tmp/sources/dwm
git clone --depth 1 -- https://github.com/foelkdavid/st /tmp/sources/st

# other, 
git clone --depth 1 -- https://github.com/nsxiv/nsxiv /tmp/sources/nsxiv
git clone --depth 1 -- https://github.com/torrinfail/dwmblocks /tmp/sources/dwmblocks

mkdir -p $HOME/.local/src/
mv /tmp/sources/dwm $HOME/.local/src/dwm && cd $HOME/.local/src/dwm && make && sudo make install
mv /tmp/sources/dwmblocks $HOME/.local/src/dwmblocks && cd $HOME/.local/src/dwmblocks && make && sudo make install
mv /tmp/sources/st $HOME/.local/src/st && cd $HOME/.local/src/st && make && sudo make install
mv /tmp/sources/nsxiv $HOME/.local/src/nsxiv && cd $HOME/.local/src/nsxiv && make && sudo make install
cd ~/


# linking config files and creating desired directories
cd $HOME/.config
mkdir dwm dwmblocks st nsxiv
ln -s ~/.local/src/dwm/config.h dwm/config.h
ln -s ~/.local/src/st/config.h st/config.h
ln -s ~/.local/src/dwmblocks/blocks.h dwm/blocks.h
ln -s ~/.local/src/nsxiv/config.h nsxiv/config.h


echo "DONE!"