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

# Workspace and projects directory.
project_path="workspace/projects"

# Create the workspace directory into the work directory.
mkdir --parents ./airootfs/root/"${project_path}"
mkdir --parents ./airootfs/root/"${project_path}"/02-init

# Copy the Arch Linux script in the workspace directory.
cp "${currentDirectory}"/../00-configuration.bash ./airootfs/root/"${project_path}"/
cp "${currentDirectory}"/../02-init/01-init-custom-iso.bash ./airootfs/root/"${project_path}"/02-init/

# Compress ArchLinux project and add into the root directory in Arch ISO.
tar --create --gzip --file ./airootfs/root/"${project_path}"/archlinux-installer-and-setup.tar "${currentDirectory}"/../../../../archlinux-installer-and-setup

funcSetupPacmanConfiguration ./
sed --in-place --regexp-extended "s/SigLevel \s*= Required DatabaseOptional/SigLevel = Never TrustAll/g" ./pacman.conf

# Set up the Profile configuration file.
sed --in-place "s/  \[\"\/root\/.automated_script.sh\"\]=\"0:0:755\"/  \[\"\/root\/.automated_script.sh\"\]=\"0:0:755\"\n  \[\"\/root\/workspace\/projects\/01-init-custom-iso.bash\"\]=\"0:0:755\"/g" ./profiledef.sh

# Build the ISO file.
sudo mkarchiso -v ./

# Rename the ISO file to the file name in the configuration.
for filename in ./out/*.iso; do
  echo "Rename: ${filename} to ./out/${archIsoFile}"
  sudo mv "${filename}" ./out/"${archIsoFile}"
done

# ------------------- #
# Create the USB Live #
# ------------------- #

# Ask if the user wants to create the USB live.
read -n 1 -r -p "Do you want to crete a USB Live? [Y/n]: " isUsbLive

funcContinueDefaultYes "${isUsbLive}"

# Display a disk partition table.
fdisk --list

# This is the list with all devices (disks and USB) connected in your computer.
# Warning: This script will delete all partitions and data from the selected device.

read -r -p "Write in lowercase the name for the USB device, e.g. sdb, sdc sdx: " usbDevice

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

# Upload Arch Linux ISO into the USB.
cat "${archIsoFilePath}" > /dev/"${usbDevice}"

# This is your formatted USB.
fdisk --list /dev/"${usbDevice}"

# Ask if the work directory for Arch ISO should be deleted.
read -n 1 -r -p "Do you want to remove the work directory for Arch ISO? [Y/n]: " isArchIsoDirectoryRemoved

# ----------------------- #
# Clean Arch ISO creation #
# ----------------------- #

if ! [[ "${isArchIsoDirectoryRemoved}" =~ ^([nN])+$ ]]; then
  sudo rm --force --recursive "${archIsoDirectory}"
  echo "The work directory for Arch ISO was deleted."
fi

# -------- #
# Finished #
# -------- #

# The next step is restart your computer and init the system with your USB.
# In the directory '/home/root/'.
# Go to the directory 'cd workspace/projects/'.
# Then execute './01-init-custom-iso.bash'.
