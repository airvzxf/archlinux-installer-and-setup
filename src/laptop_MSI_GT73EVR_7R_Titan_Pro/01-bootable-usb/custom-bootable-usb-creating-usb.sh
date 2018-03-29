#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Bootable USB
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Create a bootable USB
# ----------------------------------------------------------------------

archiso_folder="archLinuxLiveIso"

current_directory=$(pwd)

cd ~
home_directory=$(pwd)
cd ${current_directory}

iso_version=$(date +%Y.%m.%d)
archiso_file=${home_directory}/Downloads/${archiso_folder}/archlinux-${iso_version}-x86_64.iso


funcContinue() {
	if ! [[ ${1} =~ ^([yY][eE][sS]|[yY])+$ ]]; then
		echo -e ""
		echo -e "\nThe script has been FINISHED."
		exit -1
	fi
}


echo -e ""
echo -e "CREATE A BOOTABLE USB"
echo -e ""

echo -e ""
sudo fdisk -l
echo -e "This is the list with all devices (disks and USB) connected in your computer"

echo -e "\n"
echo -e "Warning: This script delete all partitions and data from the selected device.\n"

read -r -p "Write in lowercase the name for the USB device, e.g. sdb, sdc sdx: " usb_device

echo -e ""
read -n 1 -r -p "Is this (/dev/${usb_device}) the USB device? [y/N]: " is_this_the_usb
funcContinue ${is_this_the_usb}
echo -e ""

echo -e ""
echo -e "Umounting the ${usb_device} device"
sudo umount -R /dev/${usb_device} &>/dev/null
echo -e ""

echo -e "Deleting all the partitions in your USB (${usb_device})"
sudo dd if=/dev/zero of=/dev/${usb_device} bs=512 count=1 conv=notrunc &>/dev/null
echo -e ""

echo -e "Creating all partitions and formatting your USB properly"
(
	echo o # Create a new empty DOS partition table
	echo n # Add a new partition
	echo p # Primary partition
	echo 1 # Partition number
	echo   # First sector (Accept default: 1)
	echo   # Last sector (Accept default: varies)
	echo a # toggle a bootable flag
	echo w # Write changes
) | sudo fdisk /dev/${usb_device} &>/dev/null
echo -e ""

usbPartition="${usb_device}"1

echo -e "Loading Arch Linux in the USB..."
sudo dd bs=4M if=${archiso_file} of=/dev/${usb_device} status=progress &>/dev/null && sync &>/dev/null
echo -e ""

echo -e "This is your formatted USB"
sudo fdisk /dev/${usb_device} -l
echo -e ""

echo -e "\n"
echo -e "Ready! The next step is restart your computer and init the system with your USB.\n"
echo -e "Successful! The bootable USB has been created.\n"
