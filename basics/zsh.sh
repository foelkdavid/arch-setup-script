#!/bin/sh

# setting up zsh
# preparation
sudo rm -rf /etc/profile.d/bash.sh

touch /tmp/environment
echo export XAUTHORITY="$HOME/.config/x/Xauthority" >> /tmp/environment
echo export ZDOTDIR="$HOME/.config/zsh" >> /tmp/environment
sudo mv /tmp/environment /etc/environment
mkdir -p $HOME/.config/zsh

# .zshenv for environment variables
touch $HOME/.config/zsh/.zshenv
echo # USE THIS FILE FOR YOUR ENVIRONMENT VARIABLES >> $HOME/.config/zsh/.zshenv
echo -e "\n" >> $HOME/.config/zsh/.zshenv
echo export XDG_CONFIG_HOME="$HOME/.config" >> $HOME/.config/zsh/.zshenv
mkdir -p $HOME/.cache/zsh
echo export XDG_CACHE_DIR="$HOME/.cache" >> $HOME/.config/zsh/.zshenv
echo -e "\n" >> $HOME/.config/zsh/.zshenv

# .zprofile for autorunning commands on login
echo "# USE THIS FILE TO AUTORUN COMMANDS ON LOGIN" >> $HOME/.config/zsh/.zprofile


# .zshrc for configuration and commands
touch $HOME/.config/zsh/.zshrc
touch $HOME/.config/zsh/aliases
echo "# USE THIS FILE FOR SHELL CONFIGURATION AND USERCOMMANDS" >> $HOME/.config/zsh/.zshrc

sudo pacman -S --noconfirm zsh
chsh -s /bin/zsh $USER
ZSHVER=$(zsh --version | awk '{print $2}')
sudo rm /usr/lib/zsh/$ZSHVER/zsh/newuser.so


# add nice plugins
git clone --depth 1 -- https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.local/share/zsh/plugins/zsh-syntax-highlighting
git clone --depth 1 -- https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.local/share/zsh/plugins/zsh-autosuggestions


echo "DONE!"
