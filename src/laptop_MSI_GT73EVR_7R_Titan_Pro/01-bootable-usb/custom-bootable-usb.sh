#!/bin/bash -xe

# ----------------------------------------------------------------------
# Arch Linux :: Custom Bootable USB
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Create a custom bootable USB
# ----------------------------------------------------------------------

archiso_folder="archLinuxLiveIso"

current_directory=$(pwd)

cd ~
home_directory=$(pwd)
cd ${current_directory}

archiso_directory=${home_directory}/Downloads/${archiso_folder}
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
echo \
'
git
bash-completion
xorg
xorg-xinit
xorg-fonts-type1
xorg-fonts-misc
ttf-freefont
noto-fonts-emoji
xorg-xrandr
xorg-xdpyinfo
openbox
xterm
simplescreenrecorder' | sudo tee -a ./packages.both
echo -e ""


echo -e "Copying the setup files"
sudo sed -i -- 's|cp -af ${script_path}/airootfs ${work_dir}/${arch}|cp -af ${script_path}/airootfs ${work_dir}/${arch}\
\
    cp -r '${current_directory}'/../04-setup/setup-resources/.[^.]* ${work_dir}/${arch}/airootfs/root/\
\
    sed -i -- "s/wolf/root/g" ${work_dir}/${arch}/airootfs/root/.xinitrc\
\
    echo -e \"options iwlwifi 11n_disable=1 bt_coex_active=0 power_save=0 auto_agg=0 swcrypto=0\" \| tee ${work_dir}/${arch}/airootfs/etc/modprobe.d/iwlwifi.conf\
\
    echo -e '\''ACTION=="add", SUBSYSTEM=="net", KERNEL=="wlp2s*", RUN+="/usr/bin/iw dev %k set power_save off'\'' \| tee ${work_dir}/${arch}/airootfs/etc/udev/rules.d/70-wifi-powersave.rules|g' ./build.sh


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
sudo sed -i -- 's|mkarchiso|'${mkarchiso_file}'|g' ./build.sh
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
