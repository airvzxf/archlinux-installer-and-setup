#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Boinc
# ----------------------------------------------------------------------
# Berkeley Open Infrastructure for Network Computing for desktop
# Helps to the world to find solution for the physicals problems, aids,
# climate, etc.
sudo pacman -S --needed boinc

# Install libraries
sudo pacman -S --needed lib32-glibc lib32-glib2 lib32-pango lib32-libxi lib32-mesa lib32-libjpeg6-turbo lib32-libxmu

# Add your user to the boinc group
sudo usermod -a -G boinc $(whoami)

# You need logout and login again from your windows manager
#killall -15 Xorg
