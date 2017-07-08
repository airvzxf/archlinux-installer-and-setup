#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Install
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Pre-installation (EFI)
# ----------------------------------------------------------------------

#Set the keyboard layout
loadkeys "$keyboardLayout"

# Update the system clock
timedatectl set-ntp true

# Check if your computer has the EFI boot loader
# Verify the boot mode, if it is EFI.
ls /sys/firmware/efi/efivars
# Check if the motherboard works with EFI
efivar -l

# Show partitions on the disks
fdisk -l "$hardDiskDevice"

# Delete all partitions
# If you need to clean all your disk and start to zero, this is the option.
# Warning: Be careful with this command, if you are looking for clean
# all your disk and install only Arch Linux, otherwise if you have
# the partitions in your disk, skip to the gdisk command.
#cfdisk $hardDisk

# Create and setup the partitions
# Warning: This example delete all partitions and data from the hard disk,
# then create 3 partitions, first the boot loader (EFI System),
# second the Linux Swap memory (cache of the memory ram),
# third the partition for all your Arch Linux (Linux filesystem).
# When you run the command you are able to write letters or numbers in
# the terminal prompt after this "Command (? for help):"
gdisk "$hardDiskDevice"
# - o (create a new empty GUID partition table (GPT))
# - n (add a new partition)
#   - 1 (number of partition)
#   - [Enter] (start partition at, default is fine)
#   - +512M (size of this partition)
#   - EF00 (EFI System)
# - n
#   - 2
#   - [Enter]
#   - +3G
#   - 8200 (Linux Swap)
# - n
#   - 3
#   - [Enter]
#   - [Enter] (size of this partition, all the available empty space)
#   - 8300 (Linux filesystem)
# - w (write table to disk and exit)
#   - y (confirm, yes)

# Format the partitions
# If you change the order from the partitions in gdisk, take care to
# change the order from sda (sda1, sda2, sda3).
mkfs.fat -F32 "$hardDiskDeviceBoot"
mkswap "$hardDiskDeviceSwap"
swapon "$hardDiskDeviceSwap"
mkfs.ext4 "$hardDiskDeviceLinux"
fdisk -l "$hardDiskDevice"

# Mount the file systems
# Same careful for this commands.
mount "$hardDiskDeviceLinux" /mnt
mkdir /mnt/home
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount "$hardDiskDeviceBoot" /mnt/boot/efi
