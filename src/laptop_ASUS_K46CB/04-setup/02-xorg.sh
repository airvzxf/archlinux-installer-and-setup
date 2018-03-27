#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Xorg X server
# ----------------------------------------------------------------------
# This is the X Window System and it's the basic package to handle all
# the graphics system for example the desktop, windows, effects, colors,
# video games, etc.
funcIsConnectedToInternet

echo -e ""

echo -e "Installing Xorg"
sudo pacman -S --needed --noconfirm xorg
echo -e "\n"

echo -e "Installing Xorg xinit"
sudo pacman -S --needed --noconfirm xorg-xinit
echo -e "\n"

echo -e "Installing Xorg fonts"
sudo pacman -S --needed --noconfirm xorg-fonts-type1
echo -e "\n"

echo -e "Ready! The next step is run './03a01-graphic-card-nvidia.sh'.\n"
echo -e "Finished successfully!"
echo -e ""
