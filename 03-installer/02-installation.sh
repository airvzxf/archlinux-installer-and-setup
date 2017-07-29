#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Install
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Installation
# ----------------------------------------------------------------------

echo -e ""
echo -e "INSTALL ARCH LINUX IN YOUR HARD DISK DEVICE"
echo -e ""

# Download and install the base packages in your Linux partition
echo -e "Downloading and install the base packages in your Linux partition"
pacstrap /mnt base base-devel
echo -e ""

# Create a file to mount partitions automatically in the boot
echo -e "Creating the automatically mount partitions in fstab file"
genfstab -U /mnt >> /mnt/etc/fstab
echo -e ""

# Check if all your partitions are in this file (boot, swap, linux)
echo -e "Please check if all the partitions are correct:"
cat /mnt/etc/fstab
echo -e ""

echo -e "\n"
echo -e "Ready! The next step is execute the file `03-arch-change-root.sh`\n"
echo -e "Successful! You got the step 2 of 3 in your installation process.\n"
