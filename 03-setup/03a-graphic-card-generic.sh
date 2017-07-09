#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Generic graphic card
# ----------------------------------------------------------------------
# If you want to install the generic packages this is the guide,
# the cons for this is you lost a lot of performance for your graphic card
# for more performance check what is the brand and model and setup.
# This guide setup the keyboard to la-latin1, keylayout spanish-Mexico.
# If you have Nvidia card I have some script to setup it.
sudo pacman -S --noconfirm xorg-setxkbmap

# Keyboard configuration in Xorg
# https://wiki.archlinux.org/index.php/Keyboard_configuration_in_Xorg
# Dislpay information
setxkbmap -print -verbose 10
localectl list-x11-keymap-variants latam

# Setup the configuration
localectl --no-convert set-x11-keymap latam pc105 ,deadtilde

# Xbindkeys
# https://wiki.archlinux.org/index.php/Xbindkeys
sudo pacman -S --noconfirm xbindkeys
# touch ~/.xbindkeysrc
xbindkeys -d > ~/.xbindkeysrc
# Identifying keycodes
xbindkeys -k
# Reload the configuration file and apply the changes
xbindkeys -p
xbindkeys
