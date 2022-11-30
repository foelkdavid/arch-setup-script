#!/bin/sh



# setting up vim
# preparation
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm neovim
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