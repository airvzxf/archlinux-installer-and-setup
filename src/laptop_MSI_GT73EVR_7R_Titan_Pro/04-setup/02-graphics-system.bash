#!/usr/bin/env bash
set -ve

# ----------------------------------------------------------------------
# Arch Linux :: Set up - Graphics system
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

source ./../00-configuration.bash

funcIsConnectedToInternet

# ----------- #
# SET UP XORG #
# ----------- #

# ------------------- #
# Set up the generals #
# ------------------- #

# Install the X Terminal Emulator.
optional-packages --install yes xterm

# Install Xorg fonts.
optional-packages --install yes xorg-fonts-100dpi
optional-packages --install yes xorg-fonts-75dpi
optional-packages --install yes xorg-fonts-alias-100dpi
optional-packages --install yes xorg-fonts-alias-75dpi
optional-packages --install yes xorg-fonts-alias-cyrillic
optional-packages --install yes xorg-fonts-alias-misc
optional-packages --install yes xorg-fonts-cyrillic
optional-packages --install yes xorg-fonts-encodings
optional-packages --install yes xorg-fonts-misc
optional-packages --install yes xorg-fonts-type1

# Install Xorg.
sudo pacman --sync --needed --noconfirm xorg

# Install the X.Org initialisation program.
optional-packages --install yes xorg-xinit

# Install Xorg xrandr.
optional-packages --install yes xorg-xrandr

# Install the Xorg xdisplay info.
optional-packages --install yes xorg-xdpyinfo

# Install the Highly configurable and lightweight X11 window manager.
optional-packages --install yes openbox

# Install the turns on the numlock key in X11.
optional-packages --install yes numlockx

# Xbindkeys
# https://wiki.archlinux.org/index.php/Xbindkeys
# Install the launch shell commands with your keyboard or your mouse under X.
optional-packages --install yes xbindkeys

# Set up the Xbind keys.
# The command 'xmodmap', shows the keymaps and button mappings.
# Refresh the bind keys
xbindkeys --poll-rc

# -------- #
# Finished #
# -------- #

# The next step is set up NVIDIA.
# Execute './03a01-graphic-card-nvidia.bash'.
