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
funcMkdir ~/workspace
funcMkdir ~/Downloads/temp

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
sudo pacman -Syyu

# Uncomment #Color, if you want the pacman's output has colors
#Color
sudo sed -i '/Color$/ s/^##*//' /etc/pacman.conf



# Yaourt
# ----------------------------------------------------------------------

# Install yaourt: a pacman frontend which install the AUR packages.
funcInstallAur package-query
funcInstallAur yaourt

cd ~/Downloads/temp
git clone https://aur.archlinux.org/yaourt.git
cd ~/Downloads/temp/yaourt
makepkg -si
