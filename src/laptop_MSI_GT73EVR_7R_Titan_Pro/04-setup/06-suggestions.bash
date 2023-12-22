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
# Install the Virtualbox host kernel modules for Arch Kernel.
# Install the official VirtualBox Guest Additions ISO image.
# Install the VirtualBox Guest userspace utilities.
# Install the powerful x86 virtualization for enterprise as well as home use.
# Install the GNU Image Manipulation Program.
# Install the English help files for Gimp.
# Install the Spanish help files for Gimp.
sudo pacman --sync --needed --noconfirm \
  docker virtualbox-host-modules-arch virtualbox-guest-iso virtualbox-guest-utils virtualbox \
  gimp gimp-help-en gimp-help-es

# Add Docker to the user group.
sudo usermod -aG docker "${userId}"

# Install a proprietary music streaming service.
#gpg --recv-keys 13B00F1FD2C19886 # This is the public key for Spotify AUR
# Install the tool to manage all your JetBrains Projects and Tools.
yay --sync --needed --noconfirm \
  spotify jetbrains-toolbox

# -------- #
# Finished #
# -------- #

# Congrats! You were installed and set up Arch Linux

read -n 1 -s -r -p "Press any key to reboot."

# Reboot
sudo reboot
