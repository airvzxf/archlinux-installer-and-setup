#!/usr/bin/env bash
set -ve

# ---------------------------------------------------------------------- #
# Arch Linux :: Install with Arch Change Root                            #
# ---------------------------------------------------------------------- #
# https://github.com/airvzxf/archlinux-installer-and-setup

# ------------------------------------ #
# LOGIN AS ARCH ROOT IN YOUR PARTITION #
# ------------------------------------ #

source ./../00-configuration.bash

# shellcheck disable=SC2119
funcChangeConsoleFont

# The arch-chroot command emulate that you are login in the mount device
# and every command affect your session. It means that if you config
# your language, timezone, keyboard, etc., it will take effects when you
# reboot and login in your ArchLinux installed on your device.

funcIsConnectedToInternet

# ----------------------------------------- #
# Set up the resources for Arch Change Root #
# ----------------------------------------- #

funcMountSystem

# Clean Arch Linux project in target device.
rm --force --recursive /mnt/archlinux-installer-and-setup

# Copy this project into the root directory.
cp --recursive ./../../../../archlinux-installer-and-setup /mnt/

# Copy root user configurations into the root home.
cp --recursive ./../04-setup/setup-resources/. /mnt/root/

# -------------------- #
# Run Arch Change Root #
# -------------------- #

# Go to the main Linux partition like a root user.
arch-chroot /mnt /archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/03-installer/99-arch-change-root.bash

# ---------------------------------------- #
# Clean the resources for Arch Change Root #
# ---------------------------------------- #

# Delete the arch change scripts from the root directory.
rm --force --recursive /mnt/archlinux-installer-and-setup

# Unmount partitions.
funcUmountSystem

# Eject the ISO.
eject --no-unmount

# -------- #
# Finished #
# -------- #

# The next step is set up all the operative system.
# The machine will be rebooted, then enter with the created user.

# In the directory 'cd ~/workspace/projects/'.
# Go inside 'cd archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/'.
# Go to the folder 'cd 04-setup/'.
# and execute the file './01-basic.bash'.

read -n 1 -s -r -p "Press any key to reboot."

# Reboot
reboot
