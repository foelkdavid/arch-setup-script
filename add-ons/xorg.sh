#!/bin/sh
sudo xbps-install -S libX11 xauth xorg-minimal libXinerama libXft xrdb xinit libXrandr xrandr xclip xorg-minimal xorg-fonts mesa

touch /tmp/x.sh
echo 'export XINITRC="$HOME/.config/x/xinitrc"' >> /tmp/x.sh
sudo mv /tmp/x.sh /etc/profile.d/
mkdir -p $HOME/.config/x




# amdgpu
#sudo xbps-install xf86-video-amdgpu

# nvidia
#sudo xbps-install xf86-video-nouveau

# vmware
sudo xbps-install xf86-video-vmware

echo "exec dwm" > $HOME/.config/x/xinitrc