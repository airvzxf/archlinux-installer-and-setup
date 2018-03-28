#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Bootable USB
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Create a custom Bootable USB
# ----------------------------------------------------------------------

archisoDir=~/Downloads/archiso

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

echo -e ""
echo -e "CREATE A BOOTABLE USB"
echo -e ""
funcIsConnectedToInternet

echo -e "Installing archiso"
sudo pacman -S --needed --noconfirm archiso
echo -e "\n"

mkdir -p ${archisoDir}

cp -r /usr/share/archiso/configs/releng/* ${archisoDir}
