#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Bootable USB
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Create a bootable USB
# ----------------------------------------------------------------------


archlinuxImageURL="http://mirror.rackspace.com/archlinux/iso/latest/"

funcContinue() {
	if ! [[ "$isThisTheUsb" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
		echo -e "\nThe script has been FINISHED."
		exit -1
	fi
}



clear
sudo fdisk -l

echo -e "\n"
echo -e "Warning: This script delete all partitions and data from the selected device.\n"

read -r -p "Write in lowercase your usb device for example sdb, sdc sdx: " usbDevice

echo -e ""
read -r -p "Is this (/dev/$usbDevice) the USB device? [y/N]: " isThisTheUsb
funcContinue $isThisTheUsb

sudo umount -R /dev/$usbDevice &>/dev/null

sudo dd if=/dev/zero of=/dev/$usbDevice bs=512 count=1 conv=notrunc &>/dev/null

(
	echo o # Create a new empty DOS partition table
	echo n # Add a new partition
	echo p # Primary partition
	echo 1 # Partition number
	echo   # First sector (Accept default: 1)
	echo   # Last sector (Accept default: varies)
	echo a # toggle a bootable flag
	echo w # Write changes
) | sudo fdisk /dev/$usbDevice &>/dev/null

usbPartition="$usbDevice"1

mkdir -p ~/workspace

archlinuxISO=$(curl $archlinuxImageURL 2>/dev/null | grep -om 1 "archlinux-....\...\...-x86_64.iso" | head -n1)

echo -e ""
curl -H 'Cache-Control: no-cache' $archlinuxImageURL/$archlinuxISO > ~/workspace/$archlinuxISO

echo -e ""
echo -e "Wait, loading Arch Linux in the USB...\n"
sudo dd bs=4M if=~/workspace/$archlinuxISO of=/dev/$usbDevice status=progress &>/dev/null && sync &>/dev/null

sudo fdisk /dev/$usbDevice -l

echo -e "\n"
echo -e "Successful! The bootable USB has been created.\n"
