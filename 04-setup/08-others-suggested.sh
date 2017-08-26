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

echo -e ""
echo -e "Installing Network tools"
echo -e ""
sudo pacman -S --needed --noconfirm vnstat #A console-based network traffic monitor
sudo pacman -S --needed --noconfirm ethtool #Utility to query the network driver and hardware settings
sudo pacman -S --needed --noconfirm speedtest-cli #Command line interface for testing internet bandwidth using speedtest.net
echo -e "\n"

echo -e ""
echo -e "Installing Mind maps"
echo -e ""
sudo pacman -S --needed --noconfirm freemind
echo -e "\n"


echo -e "Finished successfully!"
echo -e ""
