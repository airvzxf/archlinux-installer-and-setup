#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Intro
# ----------------------------------------------------------------------
# Looks this documentation for more information about the specific setup

# Installation guide
# https://wiki.archlinux.org/index.php/Installation_guide

# Laptop main page contains links to article.
# https://wiki.archlinux.org/index.php/Laptop

# List of applications
# https://wiki.archlinux.org/index.php/List_of_applications

# Codecs
# https://wiki.archlinux.org/index.php/Codecs

# Openbox: window manager
# http://openbox.org/wiki/Help:Getting_started


# ----------------------------------------------------------------------
# Init
# ----------------------------------------------------------------------
# This is the basic setup


# General setup for this script and the following
# ----------------------------------------------------------------------
funcIsConnectedToInternet

# Create a temp directory for the next scripts
echo -e ""
mkdir -p ~/workspace
sudo chown -R $(whoami) ../../archLinux-installer-and-setup-master


# Pacman config
# ----------------------------------------------------------------------
# sudo nano /etc/pacman.conf

# Multilib
# Run and build 32-bit applications on 64-bit installations of Arch Linux.
# https://wiki.archlinux.org/index.php/Multilib

# Uncomment these both lines:
# [multilib]
# Include = /etc/pacman.d/mirrorlist
# This command delete the comments:
echo -e "Activing MultiLib"
sudo sed -i '/\[multilib\]/,/mirrorlist/ s/^##*//' /etc/pacman.conf
echo -e ""
echo -e "Upgrading system"
echo -e ""
sudo pacman -Syyu --noconfirm
echo -e "\n"

# Uncomment #Color, if you want the pacman's output has colors
#Color
echo -e "Activing color option in pacman"
sudo sed -i '/Color$/ s/^##*//' /etc/pacman.conf
echo -e ""



# Reflector
# ----------------------------------------------------------------------
# Retrieves the latest mirrorlist from the MirrorStatus page, filters
# the most up-to-date mirrors, sorts them by speed and overwrites.
echo -e "Installing reflector"
echo -e ""
sudo pacman -S --needed --noconfirm reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-bck-$(date +%Y-%m-%d)
echo -e "\n"

echo -e "Upgrading mirror list"
echo -e ""
sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
echo -e "\n"

echo -e "Upgrading system"
echo -e ""
sudo pacman -Syyu --noconfirm
echo -e "\n"

# Update automatically every day
echo -e "Setting up automate daily reflector update"
echo -e ""
reflectorService=/etc/systemd/system/reflector.service
sudo rm -f $reflectorService
sudo touch $reflectorService
sudo chmod 755 $reflectorService
echo -e "[Unit]" | sudo tee -a $reflectorService
echo -e "Description=Pacman mirrorlist update with reflector\n" | sudo tee -a $reflectorService
echo -e "[Service]" | sudo tee -a $reflectorService
echo -e "Type=oneshot" | sudo tee -a $reflectorService
echo -e "ExecStart=/usr/bin/reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist" | sudo tee -a $reflectorService

reflectorTimer=/etc/systemd/system/reflector.timer
sudo rm -f $reflectorTimer
sudo touch $reflectorTimer
sudo chmod 755 $reflectorTimer
echo -e "[Unit]" | sudo tee -a $reflectorTimer
echo -e "Description=Run reflector minutely" | sudo tee -a $reflectorTimer
echo -e "Requires=network-online.target" | sudo tee -a $reflectorTimer
echo -e "After=network-online.target\n" | sudo tee -a $reflectorTimer
echo -e "[Timer]" | sudo tee -a $reflectorTimer
echo -e "OnCalendar=hourly" | sudo tee -a $reflectorTimer
echo -e "RandomizedDelaySec=5min" | sudo tee -a $reflectorTimer
echo -e "Persistent=true\n" | sudo tee -a $reflectorTimer
echo -e "[Install]" | sudo tee -a $reflectorTimer
echo -e "WantedBy=timers.target" | sudo tee -a $reflectorTimer
echo -e "\n"

sudo systemctl enable reflector.timer




# Yaourt
# ----------------------------------------------------------------------

# Install yaourt: a pacman frontend which install the AUR packages.
echo -e "Installing git"
sudo pacman -S --needed --noconfirm git
echo -e "\n"

echo -e "Installing package-query"
funcInstallAur package-query
echo -e "\n"

echo -e "Installing yaourt"
funcInstallAur yaourt
echo -e "\n"


# Audio Alsa
#-----------------------------------------------------------------------
# https://wiki.gentoo.org/wiki/ALSA
echo -e "Installing Alsa utils"
sudo pacman -S --needed --noconfirm alsa-utils
echo -e "\n"

# Useful commands
#speaker-test -c2 -twav -l1
#aplay -L
#aplay --list-devices
#amixer controls | grep Master
#cat /sys/class/sound/card*/id
#cat /proc/asound/card0/pcm0p/info
#cat /proc/asound/card0/pcm3p/info


# Pulse audio
echo -e "Installing Pulse audio"
sudo pacman -S --needed --noconfirm pulseaudio
echo -e "\n"

# Set up config files
echo -e "Setting up config files"
cp ./setup-resources/.bash_profile ~/
cp ./setup-resources/.bashrc ~/
cp ./setup-resources/.toprc ~/
echo -e "\n"


echo -e "Ready! The next step is run './02-xorg.sh'.\n"
echo -e "Finished successfully!"
echo -e ""
