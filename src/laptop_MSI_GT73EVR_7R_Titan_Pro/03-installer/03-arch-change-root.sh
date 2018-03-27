#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Install
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Arch Change Root
# ----------------------------------------------------------------------
# This interesting command emulate that you are login in the mount device
# and every command affect your session, that's the meaning if you config
# your language, timezone, keyboard, etc., it will take effects when you
# reboot and login in without the USB bootloader.

echo -e ""
echo -e "LOGIN AS ARCH ROOT IN YOUR PARTITION"
echo -e ""
funcIsConnectedToInternet
funcMountSystem

# Copy these files into the mnt directory
cp 00-config.sh /mnt
cp 00r-arch-change-root.sh /mnt

# Copy this project into user workspace directory
echo -e "Copying this project into the root directory"
cp -R ../../../../archLinux-installer-and-setup /mnt/
echo -e ""

# Go to the main Linux partition like a root user.
echo -e "Going to the main Linux partition like a root user"
echo -e ""
arch-chroot /mnt /00r-arch-change-root.sh
echo -e ""

# Delete the copied files
rm -f /mnt/00-config.sh
rm -f /mnt/00r-arch-change-root.sh

# Copy wifi config into the new user
echo -e "Copying wifi config into the new user"
cp -R /etc/netctl /mnt/etc/
echo -e ""

# Unmount partitions
funcUmountSystem



echo -e "\n"
echo -e "Ready! The next step is setup all the operative system.\n"
echo -e "Successful! You have been installed Arch Linux.\n"
read -n 1 -s -r -p "Press any key to reboot"

# Reboot
reboot
