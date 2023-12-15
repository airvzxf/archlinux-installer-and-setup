#!/usr/bin/env bash
set -ve

# ---------------------------------------------------------------------- #
# Arch Linux :: Pre installation                                         #
# ---------------------------------------------------------------------- #
# https://github.com/airvzxf/archlinux-installer-and-setup

# ---------------------- #
# PRE-INSTALLATION (EFI) #
# ---------------------- #

source ./../00-configuration.bash

# Note: This installation works only in EFI computers.

# Note: If you want to install Arch Linux in another device,
# please change the hard disk vars into the configuration
# file (./../00-configuration.bash).

# shellcheck disable=SC2119
funcChangeConsoleFont

funcIsConnectedToInternet

# ------------- #
# Set up Pacman #
# ------------- #

# shellcheck disable=SC2119
funcSetupPacmanConfiguration

# Change the pacman.conf file to trust all packages, even if the signature is not correct.
sed --in-place --regexp-extended "s/SigLevel \s*= Required DatabaseOptional/SigLevel = Never TrustAll/g" /etc/pacman.conf

# Back up the mirror list of Pacman.
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup-"$(date +%Y-%m-%d-%H-%M-%S-%N)"

# Back up the reflector configuration file.
cp /etc/xdg/reflector/reflector.conf /etc/xdg/reflector/reflector-"$(date +%Y-%m-%d-%H-%M-%S-%N)".conf

# Set the mirror list of Pacman.
echo "--verbose
--protocol https
--ipv4
--completion-percent 100
--country ${countryCode}
--connection-timeout 600
--score 100
--sort score
--save /etc/pacman.d/mirrorlist
" | tee /etc/xdg/reflector/reflector.conf

# Replace the Reflector timer to daily schedule and a delay for 6 hours.
sed --in-place --regexp-extended "s/weekly with/every 12 hours with/g" /usr/lib/systemd/system/reflector.timer
sed --in-place --regexp-extended "s/OnCalendar=weekly/OnCalendar=*-*-* 00,12:00:00/g" /usr/lib/systemd/system/reflector.timer
sed --in-place --regexp-extended "s/RandomizedDelaySec=12h/RandomizedDelaySec=6h/g" /usr/lib/systemd/system/reflector.timer

# Enable the system timer to start Reflector.
systemctl enable --now reflector.timer

# Start the system timer of the Reflector.
systemctl restart reflector.timer

# Enable the automatic system service that updates the mirror list with Reflector.
systemctl enable --now reflector

# Restart the Reflector service.
systemctl restart reflector

funcCheckPacmanMirror "/etc/xdg/reflector/reflector.conf"

# Update the database sources in Arch Linux.
pacman --sync --refresh --refresh --noconfirm

# Ensure the Pacman keyring is properly initialized.
pacman-key --init

# ------------------- #
# Set up the generals #
# ------------------- #

# Set the keyboard layout.
loadkeys "${keyboardLayout}"

# Update the clock system
timedatectl set-ntp true

# Check if your computer has the EFI bootloader.
funcIsEfiBios

# -------------------- #
# Format the Hard disk #
# -------------------- #

# Show partitions on the target device.
fdisk --list "${hardDiskDevice}"

# Delete all partitions.
# Warning: This script deletes all partitions and data from the selected device.

read -n 1 -r -p "Is this '${hardDiskDevice}' the Hard Disk Device to erase? [y/N]: " isThisTheHdd

funcContinue "${isThisTheHdd}"

# Umount system partitions
funcUmountSystem

# Erase the hard disk
dd if=/dev/zero of="${hardDiskDevice}" bs=512 count=1 conv=notrunc

# Format the Hard Disk / Device.
(
  echo g                                 # Create a new empty GPT partition table
  echo n                                 # Add a new partition for Boot
  echo 1                                 # Partition number
  echo                                   # First sector (Accept default: 1)
  echo "${hardDiskDeviceBootSize}"       # Last sector (Accept default: varies)
  echo t                                 # Change a partition type
  echo 1                                 # EFI (FAT-12/16/32)
  echo n                                 # Add a new partition for swap (RAM)
  echo 2                                 # Partition number
  echo                                   # First sector (Accept default: 1)
  echo "${hardDiskDeviceSwapSize}"       # Last sector (Accept default: varies)
  echo t                                 # Change a partition type
  echo 2                                 # Select partition number
  echo 19                                # Linux swap
  echo n                                 # Add a new partition for other O.S
  echo 3                                 # Partition number
  echo                                   # First sector (Accept default: 1)
  echo "${hardDiskDeviceOtherLinuxSize}" # Last sector (Accept default: varies)
  echo t                                 # Change a partition type
  echo 3                                 # Select partition number
  echo 20                                # Linux filesystem
  echo n                                 # Add a new partition for ArchLinux
  echo 4                                 # Partition number
  echo                                   # First sector (Accept default: 1)
  echo "${hardDiskDeviceArchLinuxSize}"  # Last sector (Accept default: varies)
  echo t                                 # Change a partition type
  echo 4                                 # Select partition number
  echo 20                                # Linux filesystem
  echo w                                 # Write changes
) | fdisk "${hardDiskDevice}" &> /dev/null

# Umount partitions
funcUmountSystem

# Format the partitions
mkfs.fat -F 32 "${hardDiskDeviceBoot}"
mkswap "${hardDiskDeviceSwap}"
mkfs.ext4 -F "${hardDiskDeviceOtherLinux}"
mkfs.ext4 -F "${hardDiskDeviceArchLinux}"

# Show formatted hard disk
fdisk --list "${hardDiskDevice}"

# Mount the file systems
funcMountSystem

# -------- #
# Finished #
# -------- #

# The next step is executing the file './02-installation.bash'.
