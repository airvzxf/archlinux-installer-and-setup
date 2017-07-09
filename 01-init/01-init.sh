#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Init
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Notes
# ----------------------------------------------------------------------
# First you need to connect to Internet, if you use wire you don't need
# any special setup but if you use wifi you need to setup your network.
# Select your network and write your password.
sudo wifi-menu
# Check if your wifi connection works properly
ping -c3 google.com

# If the Boot USB with Arch Linux show some error about the sources when
# you try to instal something, execute this command.
sudo pacman -Syy

# I recommend you download this Git project in your computer if you
# want to get all files and information with the last updates.
# This project will be saved in ~/workspace/archLinux-installer-and-setup-master
sudo pacman -S --needed unzip

mkdir -p ~/workspace
cd ~/workspace
rm -fR archLinux-installer-and-setup-master

curl -LOk -H 'Cache-Control: no-cache' https://github.com/airvzxf/archLinux-installer-and-setup/archive/master.zip
unzip -o master.zip
rm -f master.zip

find ./archLinux-installer-and-setup-master -type f -iname *.sh -exec chmod +x {} \;
rm -f init.sh
