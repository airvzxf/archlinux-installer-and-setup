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

# Create a temp directory for the next scripts
mkdir -p ~/workspace
mkdir -p ~/Downloads/temp


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
sudo sed -i '/\[multilib\]/,/mirrorlist/ s/^##*//' /etc/pacman.conf
sudo pacman -Syyu --noconfirm

# Uncomment #Color, if you want the pacman's output has colors
#Color
sudo sed -i '/Color$/ s/^##*//' /etc/pacman.conf



# Reflector
# ----------------------------------------------------------------------
# Retrieves the latest mirrorlist from the MirrorStatus page, filters
# the most up-to-date mirrors, sorts them by speed and overwrites.
sudo pacman -S --needed --noconfirm reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-bck-$(date +%Y-%m-%d)

sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syyu --noconfirm

# Update automatically every day
reflectorService=sudo /etc/systemd/system/reflector.service
sudo touch $reflectorService
sudo chmod 755 $reflectorService
echo -e "[Unit]" | sudo tee -a $reflectorService
echo -e "Description=Pacman mirrorlist update with reflector\n" | sudo tee -a $reflectorService
echo -e "[Service]" | sudo tee -a $reflectorService
echo -e "Type=oneshot" | sudo tee -a $reflectorService
echo -e "ExecStart=/usr/bin/reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist" | sudo tee -a $reflectorService

reflectorTimer=/etc/systemd/system/reflector.timer
sudo touch $reflectorTimer
sudo chmod 755 $reflectorTimer
echo -e "[Unit]" | sudo tee -a $reflectorTimer
echo -e "Description=Run reflector daily\n" | sudo tee -a $reflectorTimer
echo -e "[Timer]" | sudo tee -a $reflectorTimer
echo -e "OnCalendar=daily" | sudo tee -a $reflectorTimer
echo -e "RandomizedDelaySec=12h" | sudo tee -a $reflectorTimer
echo -e "Persistent=true\n" | sudo tee -a $reflectorTimer
echo -e "[Install]" | sudo tee -a $reflectorTimer
echo -e "WantedBy=timers.target" | sudo tee -a $reflectorTimer

systemctl start reflector.service
systemctl start reflector.timer

systemctl status reflector.service
systemctl status reflector.timer



# Yaourt
# ----------------------------------------------------------------------

# Install yaourt: a pacman frontend which install the AUR packages.
funcInstallAur package-query
funcInstallAur yaourt


# Audio Alsa
#-----------------------------------------------------------------------
# https://wiki.gentoo.org/wiki/ALSA
sudo pacman -S --needed --noconfirm alsa-utils

# Useful commands
#speaker-test -c2 -twav -l1
#aplay -L
#aplay --list-devices
#amixer controls | grep Master
#cat /sys/class/sound/card*/id
#cat /proc/asound/card0/pcm0p/info
#cat /proc/asound/card0/pcm3p/info
