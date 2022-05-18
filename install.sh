#!/bin/bash

REPO="https://alpha.de.repo.voidlinux.org/current"
ARCH="x86_64"

# Adding colors for output:
red="\e[0;91m"
green="\e[0;92m"
blue="\e[0;94m"
bold="\e[1m"
reset="\e[0m"

# Styling and misc.
# convenience:
fail() {
    echo -e "${red}[FAILED]${reset}"
}

failexit() {
    fail
    exit
}

ok() {
    echo -e "${green}[OK]${reset}"
}


# Functions to be used later:

# checks if command is run as root.
rootcheck() {
    [ $(id -u) -eq 0 ] && return 0 || return 1
}

# naive networkcheck
networkcheck() {
    ping -c 2 voidlinux.org > /dev/null && return 0 || return 1
}

# gets the used BOOTLOADER.
# 0 = uefi
# 1 = bios
getbootloader() {
    [ -d /sys/firmware/efi/efivars ] && BOOTLOADER=UEFI || BOOTLOADER=BIOS
}


# calculates swapsize using a simple table
#     Amount of RAM installed in system 	Recommended swap space
# RAM ≤ 2GB :       swap = 2X RAM
# RAM = 2GB – 8GB : swap = RAM
# RAM > 8GB       : swap = 8GB
getswap() {
    RAM=$(grep MemTotal /proc/meminfo | awk '{print $2}') && RAM =$(( $RAM/1024000 ))
    if [[ RAM -lt 2 ]]; then
        SWAP=$(($RAM*2))
        elif [[ RAM -lt 8 ]]; then
        SWAP=$RAM
        elif [[ RAM -gt 8 ]]; then
        SWAP=8
    fi
}



driveselect() {
    # shows drives over 1GiB to the User
    echo -e "\t\tFollowing disks are recommendet:"
    echo -e "${bold}"
    sfdisk -l | grep "GiB" &&
    echo -e "${reset}"
    
    # allows the user to select a DISK $DISK
    while true; do
        read -p "Please enter the path of the desired Disk for your new System: " DISK &&
        [ -b "$DISK" ] && printf $(ok)" ${blue}$DISK${reset}\n" && break ||  printf $(fail)" ${blue}$DISK${reset} is not a valid drive\n"
    done
    
    echo -e "${red}This will remove all existing partitions on "$DISK". ${reset}"
    while true; do
        read -p "Are you sure? [yes/no] " YN
        printf "\t\tdrive selection: "
        case $YN in
            [yes]* ) ok && return 0;;
            [no]* ) fail && return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# creates filesystem
createfilesystem() {
    #creating efi, swap, root partition for UEFI systems; creating swap, root partition for BIOS systems
    if [ $BOOTLOADER = UEFI ]; then printf "o\nn\np\n \n \n+1G\nn\np\n \n \n+"$SWAP"G\nn\np\n \n \n \nw\n" | fdisk $DISK; else printf "o\nn\np\n \n \n+"$SWAP"G\nn\np\n \n \n \nw\n" | fdisk $DISK; fi
    partprobe $DISK &&
    #getting paths of partitions
    PARTITION1=$(fdisk -l $DISK | grep $DISK | sed 1d | awk '{print $1}' | sed -n "1p") &&
    PARTITION2=$(fdisk -l $DISK | grep $DISK | sed 1d | awk '{print $1}' | sed -n "2p") &&
    if [ $BOOTLOADER = UEFI ]; then PARTITION3=$(fdisk -l $DISK | grep $DISK | sed 1d | awk '{print $1}' | sed -n "3p"); else echo "No third Partition needet."; fi
    
    #declaring partition paths as variables
    if [ $BOOTLOADER = UEFI ]; then
        EFIPART=$PARTITION1
        SWAPPART=$PARTITION2
        ROOTPART=$PARTITION3
    else
        EFIPART="NOT DEFINED"
        SWAPPART=$PARTITION1
        ROOTPART=$PARTITION2
    fi
    
    #filesystem creation
    #efi partition
    if [ $BOOTLOADER = UEFI ]; then mkfs.fat -F32 $EFIPART; fi
    
    
    #root partition
    mkfs.ext4 $ROOTPART &&
    
    #swap partition
    mkswap $SWAPPART
}





echo -e "${bold}Starting Installer:${reset}" ; sleep 0.4

echo -e "\t${bold}Step 1 -> prerequisites:${reset}"
printf "\t\tRun as root? "; rootcheck && ok || failexit ; sleep 0.4
printf "\t\tChecking Connection: "; networkcheck && ok || failexit ; sleep 0.2
printf "\t\tGetting Bootloader: "; getbootloader && echo -e "${blue}[$BOOTLOADER]${reset}" || failexit ; sleep 1
printf "\t\tRunning Updates: " ; xbps-install -Syu && ok || failexit
printf "\t\tInstalling Parted for 'partprobe': " ; xbps-install -Sy parted && ok || failexit
printf "\n"


echo -e "\t${bold}Step 2 -> drives:${reset}" ; sleep 0.4
echo -e "\t\t${bold}Partitioning:${reset}"
driveselect || exit ; sleep 0.4

echo -e "\t\t${bold}Creating Filesystem:${reset}"
getswap ; echo -e "\t\tSwapsize: ${blue}[$SWAP GB]${reset}"
createfilesystem && ok || failexit ; sleep 0.4

echo -e "\t\t${bold}Mounting Filesystems:${reset}"
mount $ROOTPART /mnt && swapon $SWAPPART &&
if [ $BOOTMODE = UEFI ]; then mkfs.fat -F32 $EFIPART; fi
printf "\n"



echo -e "\t${bold}Step 3 -> installation:${reset}" ; sleep 0.4
# TODO: IMPLEMENT AUTOMATIC MIRRORSELECTION
# FOR NOW JUST EDIT THE REPO VARIABLE ON LINE 3

# copying rsa key from installation medium
mkdir -p /mnt/var/db/xbps/keys
cp /var/db/xbps/keys/* /mnt/var/db/xbps/keys/

# bootstrap installation with xbps-install
XBPS_ARCH=$ARCH xbps-install -Sy -r /mnt -R "$REPO" base-system

# mounting pseudo filesystem to chroot:
mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev
mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc

# copying dns configuration:
cp /etc/resolv.conf /mnt/etc/

# configure locales:
while true; do
    read -p "Please enter a valid Keymap: " KMP &&
    chroot /mnt/ loadkeys $KMP && echo "KEYMAP="$KMP >> /mnt/etc/rc.conf && break ||  printf $(fail)" ${blue}$KMP${reset} is not a valid Keymap\n"
done
chroot /mnt/ xbps-reconfigure -f glibc-locales


# configure users:
echo "creating new User" &&
read -p "Please enter a valid username: " USRNME &&
chroot /mnt/ useradd -m $USRNME &&
chroot /mnt/ passwd $USRNME &&
chroot /mnt/ usermod -a -G wheel $USRNME &&
echo "locking root user" &&
chroot /mnt/ passwd -l root &&
echo "done" &&
echo "%wheel ALL=(ALL) ALL" >> /mnt/etc/sudoers &&
echo "%wheel ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown" >> /mnt/etc/sudoers &&


# configuring fstab
echo $SWAPPART " swap swap rw,noatime,discard 0 0" >> /mnt/etc/fstab
echo $ROOTPART " / ext4 noatime 0 1" >> /mnt/etc/fstab
if [ $BOOTLOADER = UEFI ]; then echo $EFIPART " /boot ext4 noauto,noatime 0 2" >> /mnt/etc/fstab ; fi
echo "tmpfs /tmp tmpfs defaults,nosuid,nodev 0 0" >> /mnt/etc/fstab

# setting hostname
echo "setting hostname:" &&
read -p "Please enter a valid Hostname : " CHN &&
echo $CHN > /mnt/etc/hostname &&
echo "done!" &&

# setting up GRUB
if [ $BOOTLOADER = UEFI ]; then
    echo "setting up grub for UEFI system:" &&
    chroot /mnt/ xbps-install -Sy grub-x86_64-efi
    grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Void"
    echo "done";
else
    echo "setting up grub for BIOS system:" &&
    chroot /mnt/ xbps-install -Sy grub
    chroot /mnt/ grub-install $DISK
    echo "done";
fi



# installing microcode
VENDOR=$(grep vendor_id /proc/cpuinfo | head -n 1 | awk '{print $3}')
if [ $VENDOR = AuthenticAMD ]; then
    echo "detected AMD CPU"
    chroot /mnt/ xbps-install -Sy linux-firmware-amd
    elif [ $VENDOR = GenuineIntel ]; then
    echo "detected Intel CPU"
    # TODO: INSTALL INTEL DRIVERS
fi



# finalizing installation
chroot /mnt/ xbps-reconfigure -fa

# enabling networking (dhcpcd)
chroot /mnt/ ln -s /etc/sv/dhcpcd /var/service/

echo -e "\t${green}INSTALLATION COMPLETED${reset}" ; sleep 0.4
echo -e "\t${bold}enjoy your new system :)${reset}"
printf "\n"
echo "rebooting..."
cp -r add-ons /mnt/home/$USRNME
reboot now