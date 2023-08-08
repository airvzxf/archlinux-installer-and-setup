#!/bin/bash
source 00-config.bash

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
echo -e "Installing Mind maps"
echo -e ""
sudo pacman -S --needed --noconfirm freemind
echo -e "\n"


echo -e "Finished successfully!"
echo -e ""
