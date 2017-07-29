#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Init
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Notes
# ----------------------------------------------------------------------
# First you need is connect to Internet, if you use wire you don't need
# any special setup but if you use wifi you need to setup your network.

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
echo -e "INIT THE ARCH LINUX INSTALLATION"
echo -e ""
funcIsConnectedToInternet

# Check if your wifi connection works properly
echo -e "Checking if the computer has Internet connection"
ping -c3 google.com
echo -e ""

# If the Boot USB with Arch Linux show some error about the sources when
# you try to install something then execute this command.
echo -e "Updating the database sources in Arch Linux"
pacman -Syy
echo -e ""

# I recommend you download this Git project in your USB if you
# want to get all files and information with the last updates.
# This project will be saved in ~/workspace/archLinux-installer-and-setup-master
echo -e "Installing unzip package to extract zip files"
pacman -S --needed --noconfirm unzip
echo -e ""

echo -e "Removing the init.sh script which was downloaded for youd"
rm -f init.sh
echo -e ""

echo "Creating ~/workspace direcotory"
mkdir -p ~/workspace
cd ~/workspace
rm -fR archLinux-installer-and-setup-master
echo -e ""

echo -e "Downloading and extracting the project, you'll have access to the all scripts needed to your installation and setup."
curl -LOk -H 'Cache-Control: no-cache' https://github.com/airvzxf/archLinux-installer-and-setup/archive/master.zip
unzip -o master.zip
rm -f master.zip
echo -e ""

echo -e "Changing the permissions files to executable"
find ./archLinux-installer-and-setup-master -type f -iname *.sh -exec chmod +x {} \;
echo -e ""

echo -e "Going to the directory 03-installer"
cd ~/workspace/archLinux-installer-and-setup-master/03-installer/
ls -lha ./
echo -e ""

echo -e "\n"
echo -e "Ready! The next step go to '~/workspace/archLinux-installer-and-setup-master/03-installer/' and execute the first script which start with '01b-pre-installation-efi.sh'\n"
echo -e "Successful! You have been inited this project.\n"
