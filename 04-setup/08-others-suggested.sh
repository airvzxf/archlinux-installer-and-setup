#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Others Suggested
# ----------------------------------------------------------------------
# This list contains package that was useful in some time for example
# for a specific computer programming or useful utilities.
funcIsConnectedToInternet

echo -e ""
echo -e "Installing 'cmake'. A cross-platform open-source make system"
echo -e ""
sudo pacman -S --needed --noconfirm cmake
echo -e "\n"

echo -e ""
echo -e "Installing 'opencv'. Open Source Computer Vision Library"
echo -e ""
sudo pacman -S --needed --noconfirm opencv
sudo pacman -S --needed --noconfirm opencv-samples
echo -e "\n"
