#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# After install Nvidia
# ----------------------------------------------------------------------
# Then login to your session and execute this commands in the windows
# terminal (konsole).

# When you start the openbox window manager
echo -e ""

echo -e "Run nvidia xconfig"
sudo nvidia-xconfig
echo -e ""

#~ # This guide setup the keyboard to la-latin1, keylayout spanish-Mexico.
#~ # If you have Nvidia card I have some script to setup it.

#~ echo -e "Installing Xorg set xkb map"
#~ echo -e ""
#~ sudo pacman -S --needed --noconfirm xorg-setxkbmap
#~ echo -e "\n"

#~ # Keyboard configuration in Xorg
#~ # https://wiki.archlinux.org/index.php/Keyboard_configuration_in_Xorg
#~ # Dislpay information
#~ echo -e "Setting up the keyword map to Latin America"
#~ setxkbmap -print -verbose 10
#~ localectl list-x11-keymap-variants latam
#~ echo -e ""

#~ # Setup the configuration
#~ echo -e "Setting up the local keyboard to Latin America"
#~ localectl --no-convert set-x11-keymap latam pc105 ,deadtilde
#~ echo -e ""

#~ # Xbindkeys
#~ # https://wiki.archlinux.org/index.php/Xbindkeys
#~ echo -e "Installing Xbind keys"
#~ echo -e ""
#~ sudo pacman -S --needed --noconfirm xbindkeys
#~ echo -e "\n"

#~ echo -e "Setting up the xbin keys"
#~ # touch ~/.xbindkeysrc
#~ xbindkeys -d > ~/.xbindkeysrc
#~ # Identifying keycodes
#~ xbindkeys -k
#~ # Reload the configuration file and apply the changes
#~ xbindkeys -p
#~ xbindkeys
#~ echo -e "\n"

echo -e "Finished successfully!"
echo -e ""
