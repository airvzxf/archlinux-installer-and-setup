#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Video Games
# ----------------------------------------------------------------------
funcIsConnectedToInternet

echo -e ""

# Install a lot of libraries for general games from this AUR package
echo -e "Installing wine gaming libraries"
yes | sudo pacman -S --needed gcc-multilib
echo -e "\n"

echo -e "Installing wine gaming"
yay -S --needed --noconfirm wine-gaming-nine
echo -e "\n"

echo -e "Ready! The next step is run './07-steam.sh'.\n"
echo -e "Finished successfully!"
echo -e ""
