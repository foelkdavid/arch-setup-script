#!/bin/sh

sudo rm -rf /etc/locale.gen
touch /tmp/locale.gen
#echo 'de_AT@euro ISO-8869-15' >> /tmp/locale.gen
echo 'de_AT.UTF-8 UTF-8' >> /tmp/locale.gen
#echo 'de_AT ISO-8869-1' >> /tmp/locale.gen
echo 'en_US.UTF-8 UTF-8' >> /tmp/locale.gen
echo 'en_US ISO-8859-1' >> /tmp/locale.gen
sudo mv /tmp/locale.gen /etc/

sudo locale-gen