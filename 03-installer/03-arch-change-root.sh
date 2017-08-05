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
funcUmountAndMountSystem

# Copy these files into the mnt directory
cp 00-config.sh /mnt
cp 00r-arch-change-root.sh /mnt

# Go to the main Linux partition like a root user.
echo -e "Going to the main Linux partition like a root user"
arch-chroot /mnt /00r-arch-change-root.sh
echo -e ""

# Delete the copied files
rm -f 00-config.sh
rm -f 00r-arch-change-root.sh


# Unmount the main partition
echo -e "Unmounting the main partition"
umount -R /mnt
echo -e ""


echo -e "\n"
echo -e "Ready! The next step is setup.\n"
echo -e "Successful! You have been installed Arch Linux.\n"
read -n 1 -s -r -p "Press any key to reboot"

# Reboot
reboot
