#!/bin/sh

rootcheck() {
    [ $(id -u) -eq 0 ] && return 0 || return 1
}

# naive networkcheck
networkcheck() {
    ping -c 2 voidlinux.org > /dev/null && return 0 || return 1
}




echo -e "${bold}Setting up zsh:${reset}"
printf "Run as root? \n"; rootcheck && echo [ok] || exit ; sleep 0.4
printf "Checking Connection: \n"; networkcheck && echo [ok] || exit ; sleep 0.4
sudo runuser -l $SUDO_USER -c "/bin/bash zsh_setup.sh"
xbps-install -Sy zsh


echo "DONE!"