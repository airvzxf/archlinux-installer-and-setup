#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Video Games
# ----------------------------------------------------------------------
echo -e ""

# Install a lot of libraries for general games from this AUR package
echo -e "Installing wine gaming libraries"
echo -e ""
sudo bash -c 'yes | pacman -S --needed gcc-multilib'
echo -e "\n"
yaourt -S --needed --noconfirm wine-gaming-nine
echo -e "\n"


echo -e "Finished successfully!"
echo -e ""
