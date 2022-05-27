#!/bin/sh

# setting up zsh
# preparation
sudo xbps-install -Syu
sudo xbps-install -Sy git
sudo rm -rf /etc/profile.d/bash.sh

touch /tmp/zsh.sh
echo 'export ZDOTDIR="$HOME/.config/zsh"' >> /tmp/zsh.sh
sudo mv /tmp/zsh.sh /etc/profile.d/
mkdir -p $HOME/.config/zsh

# .zshenv for environment variables
touch $HOME/.config/zsh/.zshenv
echo "# USE THIS FILE FOR YOUR ENVIRONMENT VARIABLES" >> $HOME/.config/zsh/.zshenv
echo "\n" >> $HOME/.config/zsh/.zshenv
echo 'export XDG_CONFIG_HOME="$HOME/.config"' >> $HOME/.config/zsh/.zshenv
mkdir -p $HOME/.cache/zsh
echo 'export XDG_CACHE_DIR="$HOME/.cache"' >> $HOME/.config/zsh/.zshenv
echo "\n" >> $HOME/.config/zsh/.zshenv

# .zprofile for autorunning commands on login
echo "# USE THIS FILE TO AUTORUN COMMANDS ON LOGIN" >> $HOME/.config/zsh/.zprofile


# .zshrc for configuration and commands
touch $HOME/.config/zsh/.zshrc
touch $HOME/.config/zsh/aliases
echo "# USE THIS FILE FOR SHELL CONFIGURATION AND USERCOMMANDS" >> $HOME/.config/zsh/.zshrc

sudo xbps-install -Sy zsh
ZSHVER=$(zsh --version | awk '{print $2}')
sudo rm /usr/lib/zsh/$ZSHVER/zsh/newuser.so
chsh -s /bin/zsh $USER

echo "DONE!"
