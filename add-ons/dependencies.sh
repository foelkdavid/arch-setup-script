#!/bin/sh

# dependencies
sudo xbps-install -Sy python3-pip exa stress make gcc libX11-devel libXft-devel libXinerama-devel pkg-config wget imlib2-devel libexif-devel giflib-devel libwebp-devel dbus dbus-x11 || exit
ln -s /etc/sv/dbus /var/service/
