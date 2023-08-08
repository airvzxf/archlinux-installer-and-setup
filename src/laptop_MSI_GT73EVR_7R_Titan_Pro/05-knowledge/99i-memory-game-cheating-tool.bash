#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Information
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

# ----------------------------------------------------------------------
# Game Cheating, memory tool
# ----------------------------------------------------------------------

git clone https://github.com/scanmem/scanmem

sudo pacman --sync --needed --noconfirm libtool
sudo pacman --sync --needed --noconfirm readline
sudo pacman --sync --needed --noconfirm intltool
sudo pacman --sync --needed --noconfirm python
sudo pacman --sync --needed --noconfirm python-gobject
