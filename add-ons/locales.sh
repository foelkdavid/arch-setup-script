#!/bin/sh

sudo rm -rf /etc/default/libc-locales
touch /tmp/libc-locales
echo 'de_AT@euro ISO-8869-15' >> /tmp/libc-locales
echo 'de_AT.UTF-8' >> /tmp/libc-locales
echo 'de_AT ISO-8869-15' >> /tmp/libc-locales
echo 'en_US.UTF-8' >> /tmp/libc-locales
echo 'en_US ISO-8859-1' >> /tmp/libc-locales
sudo mv /tmp/libc-locales /etc/default/