#!/bin/sh
sudo xbps-install -S libX11 xauth xorg-minimal libXinerama libXft xrdb xinit libXrandr xrandr xclip xorg-minimal xorg-fonts mesa





# amdgpu
#sudo xbps-install xf86-video-amdgpu

# nvidia
#sudo xbps-install xf86-video-nouveau

# vmware
sudo xbps-install xf86-video-vmware

ln -s /etc/X11/xinit/xinitrc .config/x/xinitrc
echo "#!/bin/sh" > $HOME/.config/x/xinitrc
echo "exec dwm" >> $HOME/.config/x/xinitrc