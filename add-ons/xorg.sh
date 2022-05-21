#!/bin/sh
sudo xbps-install -S libX11 xauth xorg-minimal libXinerama libXft xrdb xinit libXrandr xrandr xclip xorg-minimal xorg-fonts mesa setxkbmap





# amdgpu
#sudo xbps-install xf86-video-amdgpu

# nvidia
#sudo xbps-install xf86-video-nouveau

# vmware
sudo xbps-install xf86-video-vmware



touch /tmp/x.sh
echo 'export XAUTHORITY="$HOME/.config/x/Xauthority"' >> /tmp/x.sh
sudo mv /tmp/x.sh /etc/profile.d/
mkdir -p $HOME/.config/x
ln -s /etc/X11/xinit/xinitrc $HOME/.config/x/xinitrc #TODO: Find a way to set .xinitrc location
sudo chown $USER:$USER $HOME/.config/x/xinitrc
printf '!#/bin/sh\n\setxkbmap de\nexec dwm\n' > $HOME/.config/x/xinitrc