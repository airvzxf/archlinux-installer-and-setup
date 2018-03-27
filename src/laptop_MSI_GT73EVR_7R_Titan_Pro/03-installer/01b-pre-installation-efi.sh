#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Install
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Pre-installation (EFI)
# ----------------------------------------------------------------------

echo -e ""
echo -e "PRE-INSTALL ARCH LINUX IN YOUR HARD DISK DEVICE"
echo -e "Note: This installation works only in EFI computers."
echo -e ""
funcIsConnectedToInternet

# Install and run reflector to update the mirror data base
echo -e "Installing reflector, which update the Arch Linux sources to use the faster and reliable"
pacman -S --needed --noconfirm reflector
echo -e ""

echo -e "Getting 5 Arch Linux's mirros sorted by rate (speed and the last update)"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-bck-$(date +%Y-%m-%d)
reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
pacman --noconfirm -Syy
echo -e ""

#Set the keyboard layout
echo -e "Setting the keyboard layout"
loadkeys ${keyboardLayout}
echo -e ""

# Update the clock system
echo -e "Updating the clock system"
timedatectl set-ntp true
echo -e ""

# Check if your computer has the EFI bootloader
echo -e "Checking if your computer has the EFI bootloader"
funcIsEfiBios

# Show partitions on the disks
echo -e "Showing ${hardDiskDevice} partition"
echo -e ""
fdisk -l ${hardDiskDevice}
echo -e ""

# Delete all partitions
# If you need to clean all your disk and start from zero
# otherwise skip to the gdisk command.
# In other case this command is an "UI" to delete, create, edit partitions
# in your hard disk or USB, it's very useful.
#cfdisk ${hardDiskDevice}

echo -e "\n"
echo -e "Warning: This script delete all partitions and data from the selected device."
echo -e ""
read -n 1 -r -p "Is this (${hardDiskDevice}) the Hard Disk Device device? [y/N]: " isThisTheHdd
echo -e ""
echo -e "NOTE: If you want to install Arch Linux in other device, please change the hard disk vars into the config file (00-config.sh)."
echo -e "Run 'fdisk -l' to see all the hard disk devices."
funcContinue ${isThisTheHdd}
echo -e ""

# Umount system partitions
funcUmountSystem

# Erease the hard disk
echo -e "Erasing your Hard Disk"
dd if=/dev/zero of=/dev/${hardDiskDevice} bs=512 count=1 conv=notrunc &>/dev/null
echo -e ""

echo -e "Formatting your Hard Disk Device"
(
	echo g # Create a new empty GPT partition table
	echo n # Add a new partition
	echo 1 # Partition number
	echo   # First sector (Accept default: 1)
	echo +512M # Last sector (Accept default: varies)
	echo t # change a partition type
	echo 1 # EFI (FAT-12/16/32)
	echo n # Add a new partition
	echo 2 # Partition number
	echo   # First sector (Accept default: 1)
	echo +32G # Last sector (Accept default: varies)
	echo t # change a partition type
	echo 2 # select partition number
	echo 19 # Linux swap
	echo n # Add a new partition
	echo 3 # Partition number
	echo   # First sector (Accept default: 1)
	echo   # Last sector (Accept default: varies)
	echo t # change a partition type
	echo 3 # select partition number
	echo 20 # Linux filesystem
	echo w # Write changes
) | fdisk /dev/${hardDiskDevice} &>/dev/null
echo -e ""

# Umount partitions
funcUmountSystem

# Format the partitions
echo -e "Formatting the partitions"
echo -e ""
mkfs.fat -F32 ${hardDiskDeviceBoot}
mkswap ${hardDiskDeviceSwap}
mkfs.ext4 -F ${hardDiskDeviceLinux}
echo -e "\n"

# Show formated hard disk
echo -e "Showing formatted hard disk"
echo -e ""
fdisk -l ${hardDiskDevice}
echo -e ""

# Mount the file systems
funcMountSystem

echo -e "\n"
echo -e "Ready! The next step is execute the file './02-installation.sh'\n"
echo -e "Successful! You got the step 1 of 3 in your installation process.\n"
