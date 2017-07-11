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
loadkeys $keyboardLayout

# Update the clock system
timedatectl set-ntp true

# Check if your computer has the EFI bootloader
ls /sys/firmware/efi/efivars
# there is another option
efivar -l

# Show partitions on the disks
fdisk -l $hardDiskDevice

# Delete all partitions
# If you need to clean all your disk and start from zero
# otherwise skip to the gdisk command.
# In other case this command is an "UI" to delete, create, edit partitions
# in your hard disk or USB, it's very useful.
#cfdisk $hardDisk

# Create and setup the partitions
# Notes: This commands delete all data in your hard disk because it
# create 3 partitions, first the bootloader (EFI System), second the
# Linux Swap memory, third your Arch Linux (Linux filesystem).
# When runs gdisk you need to write letters or numbers in the prompt
# after this "Command (? for help):"
gdisk $hardDiskDevice
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
mkfs.fat -F32 $hardDiskDeviceBoot
mkswap $hardDiskDeviceSwap
swapon $hardDiskDeviceSwap
mkfs.ext4 $hardDiskDeviceLinux
fdisk -l $hardDiskDevice

# Mount the file systems
mount $hardDiskDeviceLinux /mnt
mkdir /mnt/home
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount $hardDiskDeviceBoot /mnt/boot/efi
