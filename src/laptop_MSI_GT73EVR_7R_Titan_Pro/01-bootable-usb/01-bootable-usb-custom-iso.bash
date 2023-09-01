#!/usr/bin/env bash
set -ve

# ---------------------------------------------------------------------- #
# Arch Linux :: Custom Bootable USB from ArchLinux                       #
# ---------------------------------------------------------------------- #
# https://github.com/airvzxf/archlinux-installer-and-setup

# --------------------- #
# CREATE A BOOTABLE USB #
# --------------------- #

source ./../00-configuration.bash

funcIsConnectedToInternet

# --------------- #
# Set up Arch ISO #
# --------------- #

# Install the package Arch ISO.
sudo pacman --sync --needed --noconfirm archiso

# Arch ISO directory
echo "archIsoDirectory: ${archIsoDirectory}"

# Clean directory before make the Arch ISO.
sudo rm --force --recursive "${archIsoDirectory}"

# Create a work directory for Arch ISO.
mkdir --parents "${archIsoDirectory}"

# Copy the original Arch ISO directory into work directory.
cp --recursive /usr/share/archiso/configs/"${archIsoProfile}"/* "${archIsoDirectory}"
cd "${archIsoDirectory}" || funcDirectoryNotExist

# Add packages into 'packages.x86_64'.
echo '
# ----------------------- #
# PACKAGES FOR CUSTOM ISO #
# ----------------------- #
terminus-font
vim
git
reflector
asciinema
' >> ./packages.x86_64

# Workspace and projects directory path.
project_path="workspace/projects"

# Create the workspace directory into the work directory.
mkdir --parents ./airootfs/root/"${project_path}"

# Copy the Arch Linux script in the workspace directory.
cp --recursive "${currentDirectory}"/../../../../archlinux-installer-and-setup ./airootfs/root/"${project_path}"/

# Compress the Arch Linux script in the workspace directory.
tar --create --file ./airootfs/root/"${project_path}"/archlinux-installer-and-setup.tar "${currentDirectory}"/../../../../archlinux-installer-and-setup

# Function to change some parameters in the pacman.conf file.
funcSetupPacmanConfiguration ./

# Change the pacman.conf file to trust all packages, even if the signature is not correct.
sed --in-place --regexp-extended "s/SigLevel \s*= Required DatabaseOptional/SigLevel = Never TrustAll/g" ./pacman.conf

# Configure the profile to grant execute permissions to project scripts.
word_match='  \["/root/.automated_script.sh"\]="0:0:755"'
installer_path='  \["/root/workspace/projects/archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/03-installer/"\]="0:0:755"'
\sed --in-place "s|${word_match}|${word_match}\n${installer_path}|" ./profiledef.sh

# Build the ISO file.
sudo mkarchiso -v ./

# Rename the ISO file to the file name in the configuration.
for filename in ./out/*.iso; do
  echo "Rename: ${filename} to ./out/${archIsoFile}"
  sudo mv "${filename}" ./out/"${archIsoFile}"
done

# -------- #
# Finished #
# -------- #

# The next step is restart your computer and init the system with your USB.
# In the directory 'cd /home/root/workspace/projects/'.
# Go inside 'cd archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/'.
# Go to the folder 'cd 03-installer/'.
# and execute the file './01-pre-installation-efi.bash'.

# ------------------- #
# Create the USB Live #
# ------------------- #

# Ask if the user wants to create the USB live.
read -n 1 -r -p "Do you want to crete a USB Live? [Y/n]: " isUsbLive

funcContinueDefaultYes "${isUsbLive}"

# Display a disk partition table.
sudo fdisk --list

# This is the list with all devices (disks and USB) connected in your computer.
# Warning: This script will delete all partitions and data from the selected device.

read -r -p "Write in lowercase the name for the USB device, e.g. sdb, sdc sdx: " usbDevice

read -n 1 -r -p "Is this '/dev/${usbDevice}' the USB device? [y/N]: " isThisTheUsb

funcContinue "${isThisTheUsb}"

# Umount the USB device.
sudo umount --recursive /dev/"${usbDevice}" &> /dev/null || true

# Delete all the partitions in the selected USB.
sudo dd if=/dev/zero of=/dev/"${usbDevice}" bs=512 count=1 conv=notrunc &> /dev/null

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
) | sudo fdisk /dev/"${usbDevice}" &> /dev/null

# Upload Arch Linux ISO into the USB.
sudo cp "${archIsoFilePath}" /dev/"${usbDevice}"

# This is your formatted USB.
sudo fdisk --list /dev/"${usbDevice}"

# Ask if the work directory for Arch ISO should be deleted.
read -n 1 -r -p "Do you want to remove the work directory for Arch ISO? [Y/n]: " isArchIsoDirectoryRemoved

# ----------------------- #
# Clean Arch ISO creation #
# ----------------------- #

if ! [[ ${isArchIsoDirectoryRemoved} =~ ^([nN])+$ ]]; then
  sudo rm --force --recursive "${archIsoDirectory}"
  echo "The work directory for Arch ISO was deleted."
fi

# -------- #
# Finished #
# -------- #

# The next step is restart your computer and init the system with your USB.
# In the directory 'cd /home/root/workspace/projects/'.
# Go inside 'cd archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/'.
# Go to the folder 'cd 03-installer/'.
# and execute the file './01-pre-installation-efi.bash'.
