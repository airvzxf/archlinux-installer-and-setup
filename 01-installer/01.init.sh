#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Install
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Notes
# ----------------------------------------------------------------------
# First you need to connect to Internet, if you use wire you don't need
# any special setup but if you use wifi you need to setup your network.
# Select your network and write your password.
wifi-menu
# Check if your wifi connection works properly
ping -c3 google.com

# If you need this documents in your computer you can execute:
mkdir ~/workspace
mkdir ~/workspace/archLinuxInstaller
curl https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/ArchLinuxInstaller/00-config.sh > ~/workspace/archLinuxInstaller/00-config.sh
curl https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/ArchLinuxInstaller/01.init.sh > ~/workspace/archLinuxInstaller/01-init.sh
curl https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/ArchLinuxInstaller/02.pre-installation-efi.sh > ~/workspace/archLinuxInstaller/02-pre-installation-efi.sh
curl https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/ArchLinuxInstaller/03-installation.sh > ~/workspace/archLinuxInstaller/03-installation.sh
curl https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/ArchLinuxInstaller/04-arch-change-root.sh > ~/workspace/archLinuxInstaller/04-arch-change-root.sh
chmod +x ~/workspace/archLinuxInstaller/*.sh

# If the Boot USB with Arch Linux show some error about the sources when
# you try to instal something, execute this command.
pacman -Syy
