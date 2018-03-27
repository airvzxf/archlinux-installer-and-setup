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

# Setup the name and email using in Github.
name="Israel Roldan"
email="israel.alberto.rv@gmail.com"

# Function which check if your computer is connected to Internet.
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

# If the Boot USB with Arch Linux show some error about the sources when
# you try to install something then execute this command.
echo -e "Updating the database sources in Arch Linux"
pacman --noconfirm -Syy
echo -e ""

echo -e "Installing Git"
pacman -S --needed --noconfirm git
echo -e ""

echo -e "Removing the init.sh script which was downloaded"
rm -f init.sh
echo -e ""

echo -e "Cleaning the older downloaded project"
rm -fR ~/archLinux-installer-and-setup*
rm -fR ~/workspace/archLinux-installer-and-setup*
rm -fR ~/workspace/projects/archLinux-installer-and-setup*
echo -e ""

echo -e "Creating workspace and projects direcotory"
mkdir -p ~/workspace
mkdir -p ~/workspace/projects
cd ~/workspace/projects
echo -e ""

echo -e "Cloning the git project in your computer"
git clone https://github.com/airvzxf/archLinux-installer-and-setup.git
cd ./archLinux-installer-and-setup/
echo -e ""

echo -e "Set up Git"
git config --global user.name ${name}
git config --global user.email ${email}
./src/laptop_MSI_GT73EVR_7R_Titan_Pro/05-knowledge/99c-git-alias.sh
echo -e ""

echo -e "Going to the directory 03-installer"
cd ./src/laptop_MSI_GT73EVR_7R_Titan_Pro/03-installer/
ls -lha ./
echo -e ""

echo -e "\n"
echo -e "Ready! The next step is execute the file './01b-pre-installation-efi.sh'\n"

echo -e "The project was created in '~/workspace/projects/archLinux-installer-and-setup/'"
echo -e "Successful! You have been inited this project.\n"
