#!/bin/sh
sudo xbps-install -Sy libX11 xauth xorg-minimal libXinerama libXft xrdb xinit libXrandr xrandr xclip xorg-minimal mesa setxkbmap

# removed for testing purposes
#sudo xbps-install -Sy xorg-fonts



# amdgpu
#sudo xbps-install xf86-video-amdgpu

# nvidia
#sudo xbps-install xf86-video-nouveau

# vmware
sudo xbps-install -Sy xf86-video-vmware



touch /tmp/x.sh
echo 'export XAUTHORITY="$HOME/.config/x/Xauthority"' >> /tmp/x.sh
sudo mv /tmp/x.sh /etc/profile.d/
mkdir -p $HOME/.config/x
ln -s /etc/X11/xinit/xinitrc $HOME/.config/x/xinitrc #TODO: Find a way to set .xinitrc location
sudo chown $USER:$USER $HOME/.config/x/xinitrc
echo '#!/bin/sh' > $HOME/.config/x/xinitrc
echo 'sxhkd &' >> $HOME/.config/x/xinitrc
echo 'setxkbmap de &' >> $HOME/.config/x/xinitrc
echo '# dunst &' >> $HOME/.config/x/xinitrc
echo 'picom -b &' >> $HOME/.config/x/xinitrc
echo 'dwmblocks &' >> $HOME/.config/x/xinitrc
echo 'exec dwm' >> $HOME/.config/x/xinitrc

# SXHKD setup
mkdir -p $HOME/.config/sxhkd
echo 'super + d' > $HOME/.config/sxhkd/sxhkdrc
echo '\trofi -show drun -theme $HOME/.config/rofi/themes/appmenu.rasi' >> $HOME/.config/sxhkd/sxhkdrc
echo '\n' >> $HOME/.config/sxhkd/sxhkdrc
echo 'super + Return'  >> $HOME/.config/sxhkd/sxhkdrc
echo '\tst'  >> $HOME/.config/sxhkd/sxhkdrc