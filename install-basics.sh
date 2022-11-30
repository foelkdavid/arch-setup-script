#!/bin/sh
echo "START, please wait..."

#!/bin/sh
rootcheck() {
    [ $(id -u) -eq 0 ] && return 0 || return 1

}
rootcheck && echo "dont run this as root." && exit


# naive networkcheck
networkcheck() {
    ping -c 2 archlinux.org > /dev/null && return 0 || exit
}
printf "Checking Connection: \n"; networkcheck && echo [ok] || exit



# sudo ln -s /etc/sv/dhcpcd /var/service
# sudo sv start dhcpcd
# sleep 5
sudo pacman -Syu
sudo pacman -S --noconfirm git
chmod +x $PWD/basics/*
$PWD/basics/dependencies.sh
$PWD/basics/zsh.sh
$PWD/basics/sources.sh
$PWD/basics/dotfiles.sh
$PWD/basics/nvim.sh
$PWD/basics/xorg.sh
$PWD/basics/locales.sh
$PWD/basics/cleanup.sh