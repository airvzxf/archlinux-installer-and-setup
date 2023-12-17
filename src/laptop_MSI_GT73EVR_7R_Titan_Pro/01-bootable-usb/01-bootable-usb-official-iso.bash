#!/usr/bin/env bash
set -ve

# ---------------------------------------------------------------------- #
# Arch Linux :: Bootable USB with official ISO                           #
# ---------------------------------------------------------------------- #
# https://github.com/airvzxf/archlinux-installer-and-setup

# --------------------- #
# CREATE A BOOTABLE USB #
# --------------------- #

source ./../00-configuration.bash

funcIsConnectedToInternet

# -------------- #
# Format the USB #
# -------------- #

# Display a disk partition table.
fdisk --list

# This is the list with all devices (disks and USB) connected in your computer.
# Warning: This script will delete all partitions and data from the selected device.

read -r -p "Write in lowercase the name for the USB device, e.g., sdb, sdc sdx: " usbDevice

read -n 1 -r -p "Is this '/dev/${usbDevice}' the USB device? [y/N]: " isThisTheUsb
funcContinue "${isThisTheUsb}"

# Umount the USB device.
sudo umount --recursive /dev/"${usbDevice}" &>/dev/null || true

# Delete all the partitions in the selected USB.
dd if=/dev/zero of=/dev/"${usbDevice}" bs=512 count=1 conv=notrunc &>/dev/null

# Create all partitions and formatting your USB properly.
(
  echo o # Create a new empty DOS partition table
  echo n # Add a new partition
  echo p # Primary partition
  echo 1 # Partition number
  echo   # First sector (Accept default: 1)
  echo   # Last sector (Accept default: varies)
  echo a # Toggle a bootable flag
  echo w # Write changes
) | sudo fdisk /dev/"${usbDevice}" &>/dev/null

# ----------------------- #
# Download Arch Linux ISO #
# ----------------------- #

# Get Arch Linux ISO name.
isoRegExp="archlinux-[0-9]{4}\.[0-9]{2}\.[0-9]{2}-x86_64\.iso"
archlinuxISO=$(
  curl "${archlinuxImageURL}" 2>/dev/null |
    grep --extended-regexp --only-matching --max-count 1 "${isoRegExp}" |
    head --lines 1
)
echo "archlinuxISO: ${archlinuxISO}"

# Delete previous ISO.
rm --force ~/"${archlinuxISO}"

# Download Arch Linux ISO.
curl --header 'Cache-Control: no-cache' "${archlinuxImageURL}/${archlinuxISO}" >~/"${archlinuxISO}"

# ------------------- #
# Create the USB Live #
# ------------------- #

# Upload Arch Linux ISO into the USB.
cat ~/"${archlinuxISO}" >/dev/"${usbDevice}"

# This is your formatted USB.
fdisk --list /dev/"${usbDevice}"

# ---------------------- #
# Clean the installation #
# ---------------------- #

# Delete the ISO file.
rm --force ~/"${archlinuxISO}"

# -------- #
# Finished #
# -------- #

# The next step is restart your computer and init the system with your USB.
# Go to 'https://github.com/airvzxf/archlinux-installer-and-setup'
# Download the script 'src/laptop_MSI_GT73EVR_7R_Titan_Pro/00-configuration.bash'
# Download the script 'src/laptop_MSI_GT73EVR_7R_Titan_Pro/02-init/01-init-official-iso.bash'
# Then execute './01-init-official-iso.bash'.
