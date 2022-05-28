#!/bin/sh
echo "START, please wait..."

#!/bin/sh
rootcheck() {
    [ $(id -u) -eq 0 ] && return 0 || return 1

}
rootcheck && echo "dont run this as root." && exit


# naive networkcheck
networkcheck() {
    ping -c 2 voidlinux.org > /dev/null && return 0 || exit
}
printf "Checking Connection: \n"; networkcheck && echo [ok] || exit



# sudo ln -s /etc/sv/dhcpcd /var/service
# sudo sv start dhcpcd
# sleep 5

sudo xbps-install -Syu
sudo xbps-install -S git
chmod +x $PWD/add-ons/*
$PWD/add-ons/dependencies.sh
$PWD/add-ons/zsh.sh
$PWD/add-ons/sources.sh
$PWD/add-ons/dotfiles.sh
$PWD/add-ons/nvim.sh
$PWD/add-ons/xorg.sh
$PWD/add-ons/locales.sh
$PWD/add-ons/cleanup.sh