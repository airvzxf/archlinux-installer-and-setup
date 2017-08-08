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
#sudo pacman -R --noconfirm gcc 2>/dev/null
#sudo pacman -R --noconfirm gcc-libs
yaourt -S --needed --depends wine-gaming-nine
echo -e "\n"


echo -e "Finished successfully!"
echo -e ""
