#!/usr/bin/env bash
set -ve

# ----------------------------------------------------------------------
# Arch Linux :: Set up - Suggested packages
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

# ----------- #
# SUGGESTIONS #
# ----------- #

source ./../00-configuration.bash

funcIsConnectedToInternet

# -------- #
# Packages #
# -------- #

# Install the pack, ship and run any application as a lightweight container.
sudo pacman --sync --needed --noconfirm docker
sudo usermod -aG docker "${userId}"

# Install a proprietary music streaming service.
#gpg --recv-keys 13B00F1FD2C19886 # This is the public key for Spotify AUR
yay --sync --needed --noconfirm spotify

# -------- #
# Finished #
# -------- #

# Congrats! You were installed and set up Arch Linux

read -n 1 -s -r -p "Press any key to reboot."

# Reboot
sudo reboot
