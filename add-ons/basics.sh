#!/bin/sh

# dependencies
sudo xbps-install -Sy python3-pip stress || exit

# tools
sudo xbps-install -Sy neofetch htop cpupower || exit
pip install wheel || exit
pip install s-tui || exit