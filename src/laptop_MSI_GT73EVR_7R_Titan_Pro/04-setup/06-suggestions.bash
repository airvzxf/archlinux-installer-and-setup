#!/usr/bin/env bash
set -ve

# ----------------------------------------------------------------------
# Arch Linux :: Set up - Basics GUI
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

# Install a proprietary music streaming service.
#gpg --recv-keys 13B00F1FD2C19886 # This is the public key for Spotify AUR
yay --sync --needed --noconfirm spotify

# -------- #
# Finished #
# -------- #

# Congrats! You were installed and set up Arch Linux
