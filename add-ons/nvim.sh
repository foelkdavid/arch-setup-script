#!/bin/sh

rootcheck() {
    [ $(id -u) -eq 0 ] && return 1 || return 0
}

# naive networkcheck
networkcheck() {
    ping -c 2 voidlinux.org > /dev/null && return 0 || return 1
}

echo -e "${bold}Setting up zsh:${reset}"
printf "Run as root? \n"; rootcheck && echo [ok] || exit ; sleep 0.4
printf "Checking Connection: \n"; networkcheck && echo [ok] || exit ; sleep 0.4


# setting up vim
# preparation
sudo xbps-install -Syu
sudo xbps-install -Sy -nvim
mkdir -p $HOME/.config/nvim
touch $HOME/.config/nvim/init.vim
echo "set showmatch" >> $HOME/.config/nvim/init.vim
echo "syntax on" >> $HOME/.config/nvim/init.vim
#echo "color gruvbox" >> $HOME/.config/nvim/init.vim
echo "set background=dark" >> $HOME/.config/nvim/init.vim
echo "filetype on" >> $HOME/.config/nvim/init.vim
echo "set nocompatible" >> $HOME/.config/nvim/init.vim
echo "filetype indent on" >> $HOME/.config/nvim/init.vim
#echo "set number" >> $HOME/.config/nvim/init.vim
echo "set cursorline" >> $HOME/.config/nvim/init.vim
echo "set cursorcolumn" >> $HOME/.config/nvim/init.vim
echo "set shiftwidth=4" >> $HOME/.config/nvim/init.vim
echo "set tabstop=4" >> $HOME/.config/nvim/init.vim
echo "set scrolloff=10" >> $HOME/.config/nvim/init.vim
echo "set incsearch" >> $HOME/.config/nvim/init.vim
echo "set ignorecase" >> $HOME/.config/nvim/init.vim
echo "set showcmd" >> $HOME/.config/nvim/init.vim
echo "set showmode" >> $HOME/.config/nvim/init.vim
echo "set showmatch" >> $HOME/.config/nvim/init.vim
#echo "set hlsearch" >> $HOME/.config/nvim/init.vim
#echo "set history=1000" >> $HOME/.config/nvim/init.vim
echo "DONE"