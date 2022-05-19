#!/bin/bash

rootcheck() {
    [ $(id -u) -eq 0 ] && return 0 || return 1
}

# naive networkcheck
networkcheck() {
    ping -c 2 voidlinux.org > /dev/null && return 0 || return 1
}

echo -e "${bold}Setting up zsh:${reset}"
printf "Run as root? "; rootcheck && ok || failexit ; sleep 0.4
printf "Checking Connection: "; networkcheck && ok || failexit ; sleep 0.4


# setting up zsh
# preparation
xbps-install -Syu
xbps-install -Sy git
rm -rf /etc/profile.d/bash.sh
rm -rf $HOME/.bash*
touch /etc/profile.d/zsh.sh
echo 'export ZDOTDIR="$HOME/.config/zsh"' >> /etc/profile.d/zsh.sh
mkdir -p $HOME/.config/zsh


# .zshenv for environment variables
touch $HOME/.config/zsh/.zshenv
echo 'export XDG_CONFIG_HOME="$HOME/.config"' >> $HOME/.config/zsh/.zshenv
mkdir -p $HOME/.cache/zsh
echo 'export XDG_CACHE_DIR="$HOME/.cache"' >> $HOME/.cache


# .zprofile for autorunning commands on login
touch $HOME/.config/zsh/.zprofile

# .zshrc for configuration and commands
touch $HOME/.config/zsh/.zshrc
echo "# GENERATED BY INSTALLER:" >> $HOME/.config/zsh/.zshrc
echo -e "\n" >> $HOME/.config/zsh/.zshrc
echo "# convenience aliases:" >> $HOME/.config/zsh/.zshrc
echo 'alias reboot="sudo reboot"' >> $HOME/.config/zsh/.zshrc
echo 'alias poweroff="sudo poweroff"' >> $HOME/.config/zsh/.zshrc
echo 'alias shutdown="sudo shutdown now"' >> $HOME/.config/zsh/.zshrc
echo 'alias xi "sudo xbps-install"' >> $HOME/.config/zsh/.zshrc
echo 'alias xr "sudo xbps-remove"' >> $HOME/.config/zsh/.zshrc
echo 'alias xu "sudo xbps-install -Syu"' >> $HOME/.config/zsh/.zshrc
echo 'alias xs "sudo xbps-query -Rs"' >> $HOME/.config/zsh/.zshrc
echo -e "\n" >> $HOME/.config/zsh/.zshrc
echo "# auto cd into typed directory:" >> $HOME/.config/zsh/.zshrc
echo "setopt autocd" >> $HOME/.config/zsh/.zshrc
echo -e "\n" >> $HOME/.config/zsh/.zshrc
echo "# enable colors:" >> $HOME/.config/zsh/.zshrc
echo "autoload -U colors && colors" >> $HOME/.config/zsh/.zshrc
echo -e "\n" >> $HOME/.config/zsh/.zshrc
echo "change prompt:" >> $HOME/.config/zsh/.zshrc
echo 'PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "' >> $HOME/.config/zsh/.zshrc
echo -e "\n" >> $HOME/.config/zsh/.zshrc
echo "# fix annoying stuff" >> $HOME/.config/zsh/.zshrc
echo "# disable ctrl-s to freeze terminal" >> $HOME/.config/zsh/.zshrc
echo "stty stop undef" >> $HOME/.config/zsh/.zshrc
echo "# move .zcompdump directory" >> $HOME/.config/zsh/.zshrc
echo "autoload -Uz compinit" >> $HOME/.config/zsh/.zshrc
echo "compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION" >> $HOME/.config/zsh/.zshrc
echo -e "\n" >> $HOME/.config/zsh/.zshrc
echo "# add ctrl+a and ctrl+e support" >> $HOME/.config/zsh/.zshrc
echo "bindkey -M viins '^a' beginning-of-line" >> $HOME/.config/zsh/.zshrc
echo "bindkey -M viins '^e' end-of-line" >> $HOME/.config/zsh/.zshrc
echo -e "\n" >> $HOME/.config/zsh/.zshrc
echo "# configure shell history" >> $HOME/.config/zsh/.zshrc
echo "HISTFILE=$HOME/.cache/zsh/histfile.txt" >> $HOME/.config/zsh/.zshrc
echo "HISTSIZE=10000" >> $HOME/.config/zsh/.zshrc
echo "SAVEHIST=10000" >> $HOME/.config/zsh/.zshrc
echo -e "\n" >> $HOME/.config/zsh/.zshrc
echo "# import plugins" >> $HOME/.config/zsh/.zshrc
mkdir -p $HOME/.local/share/zsh/plugins/
git clone --depth 1 -- https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.local/share/zsh/plugins/zsh-syntax-highlighting
git clone --depth 1 -- https://github.com/zsh-users/zsh-autosuggestions.git /tmp/installer/zsh/zsh-autosuggestions
echo "source $HOME/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.config/zsh/.zshrc
echo "source $HOME/.local/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" >> $HOME/.config/zsh/.zshrc
chown -R $USER:$USER $HOME
xbps-install -Sy zsh
chsh -s /bin/zsh $USER

echo "DONE!"