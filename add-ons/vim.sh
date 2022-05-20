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
touch /tmp/vim.sh
echo 'export VIMINIT="source $MYVIMRC"' >> /tmp/vim.sh
echo 'export MYVIMRC="$HOME/.config/vim"' >> /tmp/vim.sh
sudo mv /tmp/vim.sh /etc/profile.d/
mkdir -p $HOME/.config/vim
touch $HOME/.config/vim/.vimrc