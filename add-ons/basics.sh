#!/bin/sh

# dependencies
sudo xbps-install -Sy python3-pip stress make gcc libX11-devel libXft-devel libXinerama-devel pkg-config imlib2-devel libexif-devel giflib-devel libwebp-devel dbus dbus-x11 || exit
ln -s /etc/sv/dbus /var/service/



# tools
sudo xbps-install -Sy neofetch htop cpupower || exit
pip install wheel || exit
pip install s-tui || exit