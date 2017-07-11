#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Install
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Installation
# ----------------------------------------------------------------------

# Download and install the base packages in your Linux partition
pacstrap /mnt base base-devel

# Create a file to mount partitions automatically in the boot
genfstab -U /mnt >> /mnt/etc/fstab
# Check if all your partitions are in this file (boot, swap, linux)
cat /mnt/etc/fstab
