#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Install
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Configuration
# ----------------------------------------------------------------------
# This file contain all the variables which use in the scripts of this journey

keyboardLayout="la-latin1"
hardDiskDevice="/dev/sda"
hardDiskDeviceBoot="/dev/sda1"
hardDiskDeviceSwap="/dev/sda2"
hardDiskDeviceLinux="/dev/sda3"
zoneInfo="America/New_York"
languageCode="en_US.UTF-8"
yourComputerName="wolfMachine"
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
