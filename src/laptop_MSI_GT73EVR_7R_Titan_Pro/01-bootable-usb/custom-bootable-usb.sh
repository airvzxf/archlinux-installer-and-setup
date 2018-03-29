#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Custom Bootable USB
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Create a Custom Bootable USB
# ----------------------------------------------------------------------

archiso_directory="archLinuxLiveIso"

current_directory=$(pwd)

cd ~
home_directory=$(pwd)
cd ${current_directory}

archiso_directory=${home_directory}/Downloads/${archiso_directory}
mkarchiso_file=${archiso_directory}/mkarchiso


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
echo -e "CREATE A CUSTOM BOOTABLE USB"
echo -e ""
funcIsConnectedToInternet

echo -e "Installing archiso"
sudo pacman -S --needed --noconfirm archiso
echo -e "\n"


echo -e "Cleaning before make the ISO."
sudo rm -fR ${archiso_directory}
echo -e ""


echo -e "Creating a directory in '${archiso_directory}'"
mkdir -p ${archiso_directory}
echo -e ""

echo -e "Copying the archiso directory in '${archiso_directory}'"
cp -R /usr/share/archiso/configs/releng/* ${archiso_directory}
cd ${archiso_directory}
echo -e ""

echo -e "Adding packages into 'packages.both'"
echo -e "" >> ./packages.both
echo -e "git" >> ./packages.both
echo -e ""

echo -e "Copying mkarchiso into a temporary file"
sudo cp /usr/bin/mkarchiso ${mkarchiso_file}
ls -lha ${mkarchiso_file}
echo -e ""

#~ echo -e "Added option '-i' in 'pacstrap' command"
#~ sudo sed -i -- 's/pacstrap -C "${pacman_conf}" -c/pacstrap -C "${pacman_conf}" -i -c/g' ${mkarchiso_file}
#~ echo -e ""

echo -e "Added the debug mode into 'build.sh'"
sudo sed -i -- 's/bash/bash -x/g' ./build.sh
echo -e ""

echo -e "Changed path directory from mkarchiso in 'build.sh'"
sudo sed -i -- 's/mkarchiso/'${mkarchiso_file}'/g' ./build.sh
echo -e ""

echo -e "Building the ISO file"
sudo ./build.sh -v
echo -e ""

echo -e "Going back to the directory where you executed this script."
cd ${current_directory}
echo -e ""


echo -e "\n"
echo -e "Finished!!!"
echo -e "\n"
