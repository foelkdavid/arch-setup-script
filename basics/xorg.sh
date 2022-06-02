#!/bin/sh
sudo xbps-install -Sy libX11 xwallpaper xauth xorg-minimal libXinerama libXft xrdb xinit libXrandr xrandr xclip xorg-minimal mesa setxkbmap

# removed for testing purposes
sudo xbps-install -Sy xorg-fonts



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
echo 'xwallpaper --zoom $HOME/.config/x/wallpaper.jpg &' >> $HOME/.config/x/xinitrc
echo 'exec dwm' >> $HOME/.config/x/xinitrc

#get wallpaper
 wget -O $HOME/.config/x/wallpaper.jpg https://ia800301.us.archive.org/18/items/mma_a_country_road_437586/437586.jpg

#add icon fonts
sudo xbps-install -S p7zip wget
mkdir ~/.config/fonts
ln -s ~/.config/fonts ~/.fonts
wget -O /tmp/fa.zip https://github.com/FortAwesome/Font-Awesome/releases/download/6.1.1/fontawesome-free-6.1.1-desktop.zip
7z /tmp/fa.zip -o{fa}
cp /tmp/fa/otfs/* ~/.fonts

# SXHKD setup
mkdir -p $HOME/.config/sxhkd
echo 'super + d' > $HOME/.config/sxhkd/sxhkdrc
echo '\trofi -show drun -theme $HOME/.config/rofi/themes/appmenu.rasi' >> $HOME/.config/sxhkd/sxhkdrc
echo '\n' >> $HOME/.config/sxhkd/sxhkdrc
echo 'super + Return'  >> $HOME/.config/sxhkd/sxhkdrc
echo '\tst'  >> $HOME/.config/sxhkd/sxhkdrc