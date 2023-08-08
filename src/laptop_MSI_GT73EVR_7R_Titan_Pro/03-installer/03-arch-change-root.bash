#!/usr/bin/env bash
set -ve

# ---------------------------------------------------------------------- #
# Arch Linux :: Install with Arch Change Root                            #
# ---------------------------------------------------------------------- #
# https://github.com/airvzxf/archLinux-installer-and-setup

# ------------------------------------ #
# LOGIN AS ARCH ROOT IN YOUR PARTITION #
# ------------------------------------ #

source ./../00-configuration.bash

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

# Copy the arch change sripts into the root directory
cp ./../00-configuration.bash /mnt
cp 99-arch-change-root.bash /mnt

# Copy this project into the root directory
cp -R ../../../../archLinux-installer-and-setup /mnt/

# Copy root user configurations into the root home
cp -R ../04-setup/setup-resources/. /mnt/root/

# -------------------- #
# Run Arch Change Root #
# -------------------- #

# Go to the main Linux partition like a root user.
arch-chroot /mnt /99-arch-change-root.bash

# ---------------------------------------- #
# Clean the resources for Arch Change Root #
# ---------------------------------------- #

# Delete the arch change sripts from the root directory
rm -f /mnt/00-configuration.bash
rm -f /mnt/99-arch-change-root.bash

# Unmount partitions
funcUmountSystem

# Eject the ISO.
eject -m

# -------- #
# Finished #
# -------- #

# The next step is set up all the operative system.
# The machine will be reboot, then enter with the created user.

# In the directory 'cd ~/workspace/projects/'.
# Go inside 'cd archLinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/'.
# Go to the folder 'cd 04-setup/'.
# and execute the file './01-setup.bash'.

read -n 1 -s -r -p "Press any key to reboot"

# Reboot
reboot
