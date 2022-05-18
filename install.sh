#!/bin/bash

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

# gets the used bootmode.
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
    RAM=$(free -g | grep Mem: | awk '{print $2}')
    if [[ RAM -lt 2 ]]; then
        SWAP=$(($RAM*2))
        elif [[ RAM -lt 8 ]]; then
        SWAP=$RAM
        elif [[ RAM -gt 8 ]]; then
        SWAP=8
    fi
}



#setting swapsize variable to RAMsize+4G
SWAPSIZE=$(expr $RAM + 4) &&
echo "SWAPSIZE = "  $SWAPSIZE &&


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
    if [ $BOOTMODE = UEFI ]; then printf "o\nn\np\n \n \n+1G\nn\np\n \n \n+"$SWAPSIZE"G\nn\np\n \n \n \nw\n" | fdisk $DSK; else printf "o\nn\np\n \n \n+"$SWAPSIZE"G\nn\np\n \n \n \nw\n" | fdisk $DSK; fi
    partprobe $DSK &&
    #getting paths of partitions
    PARTITION1=$(fdisk -l $DSK | grep $DSK | sed 1d | awk '{print $1}' | sed -n "1p") &&
    PARTITION2=$(fdisk -l $DSK | grep $DSK | sed 1d | awk '{print $1}' | sed -n "2p") &&
    if [ $BOOTMODE = UEFI ]; then PARTITION3=$(fdisk -l $DSK | grep $DSK | sed 1d | awk '{print $1}' | sed -n "3p"); else echo "No third Partition needet."; fi
    
    #declaring partition paths as variables
    if [ $BOOTMODE = UEFI ]; then
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
    if [ $BOOTMODE = UEFI ]; then mkfs.fat -F32 $EFIPART; fi
    
    
    echo $ROOTPART
    
    #root partition
    mkfs.ext4 $ROOTPART &&
    
    
    #swap partition
    swapon $SWAPPART
}





echo -e "${bold}Starting Installer:${reset}"
echo -e "\t${bold}Step 1 -> prerequisites:${reset}"
printf "\t\tRun as root? "; rootcheck && ok || failexit ; sleep 0.4
printf "\t\tChecking Connection: "; networkcheck && ok || failexit ; sleep 0.2
printf "\t\tGetting Bootloader: "; getbootloader && echo -e "${blue}[$BOOTLOADER]${reset}" || failexit ; sleep 1
printf "\n"
echo -e "\t${bold}Step 2 -> drives:${reset}"
echo -e "\t\t${bold}Partitioning:${reset}"
driveselect || exit ; sleep 1
getswap ; echo -e "\t\tSwapsize: ${blue}[$SWAP GB]${reset}"

