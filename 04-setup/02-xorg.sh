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
sudo pacman -S --needed xorg-xinit
sudo pacman -S --needed xorg-fonts-type1
