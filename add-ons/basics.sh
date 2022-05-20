#!/bin/sh

# dependencies
sudo xbps-install -Sy python3-pip

# tools
sudo xbps-install -Sy neofetch htop cpupower
pip install wheel s-tui