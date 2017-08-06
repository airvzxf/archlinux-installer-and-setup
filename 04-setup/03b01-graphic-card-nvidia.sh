#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Nvidia graphic card
# ----------------------------------------------------------------------
# When upgrade pacman some time we lost the nvidia drivers we need to
# re-install that.

# Check what graphic cards have in your computer
lspci -k | grep -A 2 -E "(VGA|3D)"

# Install basic packages
sudo pacman -S --needed linux-headers
sudo pacman -S --needed xorg-xrandr
sudo pacman -S --needed xorg-xdpyinfo
sudo pacman -S --needed xorg-fonts-type1
sudo pacman -S --needed bbswitch

# Install nvidia packages
yaourt -S --needed --noconfirm nvidia-utils-beta
yaourt -S --needed --noconfirm nvidia-beta
yaourt -S --needed --noconfirm nvidia-xrun

# Install the windows manager
sudo pacman --needed -S openbox
sudo pacman --needed -S acpid

# If you try to run the command xinit your screen freezen to solve this
# problem you need to install nvidia-xrun which avoid this problem and
# you need to create a file to setup enviorement in this example we have
# three lines:
# 1. xrandr setup your display appropriated
# 2. setxkbmap setup your keyword map and layout because xrun avoid all
# the xorg configs, every Xorg setup you need to put in this file.
# 3. openbox open the window manager (desktop)
echo -e "xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112" > ~/.nvidia-xinitrc
echo -e "setxkbmap -model pc105 -layout latam -variant ,deadtilde" >> ~/.nvidia-xinitrc
echo -e "openbox-session" >> ~/.nvidia-xinitrc
echo -e ""

# Install konsole before run openbox window manager
echo -e "Installing konsole before run openbox window manager"
sudo pacman -S --needed --noconfirm konsole # Terminal / Console window
echo -e ""



# Reboot
read -n 1 -s -r -p "Press any key to reboot"
reboot
