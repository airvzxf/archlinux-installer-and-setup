#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Steam
# ----------------------------------------------------------------------
# https://wiki.archlinux.org/index.php/Steam
# https://wiki.archlinux.org/index.php/Steam/Troubleshooting
# https://wiki.archlinux.org/index.php/Steam/Game-specific_troubleshooting
# https://wiki.archlinux.org/index.php/Gamepad

# Install packages
yaourt -S --needed --noconfirm  steam-native-runtime
yaourt -S --needed --noconfirm lib32-libopenssl-1.0-compat
sudo pacman -S --needed --noconfirm nvidia
sudo pacman -S --needed --noconfirm nvidia-libgl
sudo pacman -S --needed --noconfirm lib32-nvidia-libgl


# Missing libraries
# ----------------------------------------------------------------------

# Run steam, if you got this errors
# libGL error: No matching fbConfigs or visuals found
# libGL error: failed to load driver: swrast
sudo pacman -S --needed --noconfirm lib32-nvidia-utils

# Steam has a good commands to check all the missing libraries
# All this libraries should be there in MultiLib repositories
cd ~/.local/share/Steam/ubuntu12_32
file * | grep ELF | cut -d: -f1 | LD_LIBRARY_PATH=. xargs ldd | grep 'not found' | sort | uniq


# libXtst.so.6 => not found
sudo pacman -S --needed --noconfirm lib32-libxtst

# libgio-2.0.so.0 => not found
# libglib-2.0.so.0 => not found
# libgobject-2.0.so.0 => not found
sudo pacman -S --needed --noconfirm lib32-libdbusmenu-glib

# libfontconfig.so.1 => not found
# libfreetype.so.6 => not found
sudo pacman -S --needed --noconfirm lib32-fontconfig

# libgdk_pixbuf-2.0.so.0 => not found
sudo pacman -S --needed --noconfirm lib32-gdk-pixbuf2

# libopenal.so.1 => not found
sudo pacman -S --needed --noconfirm lib32-openal

# libXrandr.so.2 => not found
sudo pacman -S --needed --noconfirm lib32-libxrandr

# libXinerama.so.1 => not found
sudo pacman -S --needed --noconfirm lib32-libxinerama

# libusb-1.0.so.0 => not found
sudo pacman -S --needed --noconfirm lib32-libusb

# libudev.so.0 => not found
sudo pacman -S --needed --noconfirm lib32-libudev0-shim

# libICE.so.6 => not found
# libSM.so.6 => not found
sudo pacman -S --needed --noconfirm lib32-libsm

# libpulse.so.0 => not found
sudo pacman -S --needed --noconfirm lib32-libpulse

# libdbus-glib-1.so.2 => not found
# libnm-glib.so.4 => not found
# libnm-util.so.2 => not found
sudo pacman -S --needed --noconfirm lib32-libnm-glib

# libgtk-x11-2.0.so.0 => not found
sudo pacman -S --needed --noconfirm lib32-gtk2

# Others
sudo pacman -S --needed --noconfirm lib32-libxft
sudo pacman -S --needed --noconfirm lib32-freetype2
sudo pacman -S --needed --noconfirm lib32-libpng12
