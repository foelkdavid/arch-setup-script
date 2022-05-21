#!/bin/sh
sudo xbps-install -S libX11 xauth xorg-minimal libXinerama libXft xrdb xinit libXrandr xrandr xclip xorg-minimal xorg-fonts mesa





# amdgpu
#sudo xbps-install xf86-video-amdgpu

# nvidia
#sudo xbps-install xf86-video-nouveau

# vmware
sudo xbps-install xf86-video-vmware

mkdir -p $HOME/.config/x
ln -s /etc/X11/xinit/xinitrc $HOME/.config/x/xinitrc
sudo chown $USER:$USER $HOME/.config/x/xinitrc
printf "\!#/bin/sh\nexec dwm" > $HOME/.config/x/xinitrc