#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Install
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Configuration
# ----------------------------------------------------------------------
# This file contain all the variables which use in the scripts of this journey

keyboardLayout="us"
hardDiskDevice="/dev/nvme0n1"
hardDiskDeviceBoot="/dev/nvme0n1p1"
hardDiskDeviceSwap="/dev/nvme0n1p2"
hardDiskDeviceLinux="/dev/nvme0n1p3"
zoneInfo="America/New_York"
languageCode="en_US.UTF-8"
yourComputerName="MSI_GT73EVR_7RF"
yourUserName="wolf"

funcContinue() {
	if ! [[ $1 =~ ^([yY][eE][sS]|[yY])+$ ]]; then
		echo -e "\nThe script has been FINISHED."
		exit -1
	fi
}

funcIsConnectedToInternet() {
	if ! ping -c 1 google.com >> /dev/null 2>&1; then
		echo -e ""
		echo -e "You have problems with your Internet."
		echo -e "Please check if: "
		echo -e "- The Internet works properly"
		echo -e "- The Internet cable is connected to your computer and modem"
		echo -e "- If you have wifi please execute this command: 'wifi-menu' and connect in your account"
		echo -e ""
		exit -1
	fi
}

funcMountSystem() {
	echo -e "Mounting the file systems"
	mkdir -p /mnt/home
	mkdir -p /mnt/boot
	# mkdir -p /mnt/boot/efi
	mkdir -p /mnt/boot/EFI
	fuser -k /mnt
	umount -R /mnt
	swapoff -a
	mount $hardDiskDeviceLinux /mnt
	# mount $hardDiskDeviceBoot /mnt/boot/efi
	mount $hardDiskDeviceBoot /mnt/boot/EFI
	swapon $harDiskDeviceSwap
	echo -e ""
}

funcUmountSystem() {
	echo -e "Umounting the file systems"
	fuser -k /mnt
	umount -R /mnt
	swapoff -a
	echo -e ""
}

funcAddTextAtTheEndOfFile() {
	if ! grep -Fxq "$1" $2; then
		echo -e "Adding text at the end of the file $2"
		echo -e "$1"
		echo "$1" >> $2
		echo -e ""
	fi
}

funcIsEfiBios() {
	if ! [[ $(ls -A /sys/firmware/efi/efivars) ]]; then
		echo -e ""
		echo -e "This script only run the Arch Linux in EFI BIOS, sorry."
		echo -e ""
		echo -e "The script has been FINISHED."
		exit -1
	fi
}
