#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

# ----------------------------------------------------------------------
# Upgrade Nvidia when you upgrade pacman packages
# ----------------------------------------------------------------------
# When you upgrade, its upgrade your package and Linux
# core libraries you need to upgrade your nvidia because it doesn't
# upgrade automatically.
# Normally, when you reboot your computer and try to star nvidia-xrun
# this doesn't work, then you need to follow this commands.
sudo pacman -S --noconfirm linux-headers

yay --sync --needed --noconfirm nvidia-utils
yay --sync --needed --noconfirm nvidia
