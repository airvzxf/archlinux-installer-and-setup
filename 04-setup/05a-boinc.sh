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
funcIsConnectedToInternet

echo -e ""

echo -e "Installing boinc"
echo -e ""
sudo pacman -S --needed --noconfirm boinc
echo -e "\n"

# Install libraries
echo -e "Installing libraries"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-glibc lib32-glib2 lib32-pango lib32-libxi lib32-mesa lib32-libjpeg6-turbo lib32-libxmu
echo -e "\n"

# Add your user to the boinc group
echo -e "Adding user to boinc group"
sudo usermod -a -G boinc $(whoami)
echo -e ""

echo -e "Ready! The next step is run './05b-boinc-after-install.sh'.\n"

# You need logout and login again from your windows manager
read -n 1 -s -r -p "Press any key to reboot"
sudo reboot
