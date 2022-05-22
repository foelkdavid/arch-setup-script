#!/bin/sh

# generate locales
sudo rm /etc/default/libc-locales
touch /tmp/libc-locales
echo 'de_AT@euro ISO-8869-15' >> /tmp/libc-locales
echo 'de_AT.UTF-8' >> /tmp/libc-locales
echo 'de_AT ISO-8869-15' >> /etmplibc-locales
echo 'en_US.UTF-8' >> /tmp/libc-locales
echo 'en_US ISO-8859-1' >> /tmp/libc-locales
sudo mv /tmp/libc-locales /etc/default/
sudo chown root:root /etc/default/libc-locales
sudo xbps-reconfigure -f glibc-locales

# dependencies
sudo xbps-install -Sy python3-pip stress make gcc libX11-devel libXft-devel libXinerama-devel pkg-config imlib2-devel libexif-devel giflib-devel libwebp-devel dbus dbus-x11 || exit
ln -s /etc/sv/dbus /var/service/



# tools
sudo xbps-install -Sy neofetch htop cpupower || exit
pip install wheel || exit
pip install s-tui || exit