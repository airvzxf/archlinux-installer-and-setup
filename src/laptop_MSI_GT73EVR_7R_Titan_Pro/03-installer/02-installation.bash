#!/usr/bin/env bash
set -ve

# ---------------------------------------------------------------------- #
# Arch Linux :: Installation                                             #
# ---------------------------------------------------------------------- #
# https://github.com/airvzxf/archlinux-installer-and-setup

# ------------------------------------------- #
# INSTALL ARCH LINUX IN YOUR HARD DISK DEVICE #
# ------------------------------------------- #

source ./../00-configuration.bash

# shellcheck disable=SC2119
funcChangeConsoleFont

funcIsConnectedToInternet

# ----------------------------------- #
# Install Arch Linux in the Hard disk #
# ----------------------------------- #

funcMountSystem

funcCheckPacmanMirror

# Download and install the base packages in your Linux partition
# Note: The only configuration file which is copied is the '/etc/mirrorlist'.
pacstrap -K /mnt base base-devel linux linux-firmware terminus-font reflector

funcCheckPacmanMirror

funcCheckPacmanMirror /mnt/etc/pacman.d/mirrorlist

# ---------------------- #
# Create mount partition #
# ---------------------- #

# Create a file to mount partitions automatically in the boot
genfstab -U -p /mnt > /mnt/etc/fstab

# Check if all your partitions are in fstab file (boot, swap, linux)
cat /mnt/etc/fstab

# -------- #
# Finished #
# -------- #

# The next step is execute the file './03-arch-change-root.bash'.
