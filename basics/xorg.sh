#!/bin/sh
sudo pacman -S --noconfirm xwallpaper xorg-xauth xorg xorg-xrdb xorg-xinit xclip mesa xorg-setxkbmap

# removed for testing purposes
sudo pacman -S --noconfirm xorg-fonts ttf-roboto ttf-roboto-mono



# amdgpu
#sudo pacman -S --noconfirm xf86-video-amdgpu

# nvidia
#sudo pacman -S --noconfirm xf86-video-nouveau

# vmware
sudo pacman -S --noconfirm xf86-video-vmware



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
sudo pacman -S --noconfirm p7zip wget
mkdir ~/.config/fonts
ln -s ~/.config/fonts ~/.fonts
wget -O /tmp/fa.zip https://github.com/FortAwesome/Font-Awesome/releases/download/6.1.1/fontawesome-free-6.1.1-desktop.zip
7z x /tmp/fa.zip -o/tmp/fa
cp /tmp/fa/*/otfs/* ~/.fonts

# SXHKD setup
mkdir -p $HOME/.config/sxhkd
echo -e 'super + d' > $HOME/.config/sxhkd/sxhkdrc
echo -e '\trofi -show drun -theme $HOME/.config/rofi/themes/appmenu.rasi' >> $HOME/.config/sxhkd/sxhkdrc
echo -e '\n' >> $HOME/.config/sxhkd/sxhkdrc
echo -e 'super + Return'  >> $HOME/.config/sxhkd/sxhkdrc
echo -e '\tst'  >> $HOME/.config/sxhkd/sxhkdrc