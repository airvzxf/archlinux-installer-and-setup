#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Install
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Arch Change Root
# ----------------------------------------------------------------------
# Setup all the basics in the hard drive Arch Linux

# Set the keyboard layout
echo -e "Setting the keyboard layout"
loadkeys ${keyboardLayout}
echo -e ""

# Set the time zone
echo -e "Setting the time zone"
pacman -S --needed --noconfirm ntp

timedatectl set-timezone ${zoneInfo}
ntpd -qg
timedatectl set-ntp true
hwclock --systohc
echo -e ""

# Set the locale
# Uncomment en_US.UTF-8 UTF-8 or find your language and charset
# nano /etc/locale.gen
# This command auto delete the comments in /etc/locale.gen
echo -e "Setting the language and charset into locale"
sed -i "/[^ ]${languageCode} UTF-8/ s/^##*//" /etc/locale.gen
locale-gen
echo -e ""

echo -e "Setting the language into locale config"
echo "LANG=${languageCode}" > /etc/locale.conf
echo -e ""

echo -e "Setting the keyboard layout into vconsole config"
echo "KEYMAP=${keyboardLayout}" > /etc/vconsole.conf
echo -e ""

# Set the hostname
echo -e "Setting the hostname"
echo ${yourComputerName} > /etc/hostname
funcAddTextAtTheEndOfFile "127.0.1.1    localhost.localdomain    ${yourComputerName}" /etc/hosts

# Install basic package
echo -e "Installing basic packages"
pacman -S --needed --noconfirm wpa_supplicant
pacman -S --needed --noconfirm dialog
pacman -S --needed --noconfirm vim
pacman -S --needed --noconfirm git
pacman -S --needed --noconfirm grub
pacman -S --needed --noconfirm efibootmgr
pacman -S --needed --noconfirm dosfstools
pacman -S --needed --noconfirm os-prober
pacman -S --needed --noconfirm mtools
echo -e ""

# Install EFI into Grub
echo -e "Installing EFI into Grub"
grub-install --target=x86_64-efi  --bootloader-id=grub_uefi --recheck
echo -e ""

# Initramfs, create an initial ramdisk environment
echo -e "Creating an initial ramdisk environment"
mkinitcpio -p linux
echo -e ""

# Config Grub
echo -e "Setting the grub config"
echo -e ""

echo -e "Changing the initial timeout from 5 to 0 second"
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet video.use_native_backlight=1"/g' /etc/default/grub
echo -e ""

echo -e "Creating the grub config file"
grub-mkconfig -o /boot/grub/grub.cfg
echo -e ""

# Change root password
echo -e "Please change your root password:"
passwd
echo -e ""

# Create your user and password
echo -e "Creating your user (${yourUserName})"
useradd -m -g users -G wheel,storage,power -s /bin/bash ${yourUserName}
echo -e ""

echo -e "Please change your user password:"
passwd ${yourUserName}
echo -e ""

echo -e "Add your user (${yourUserName}) to the video group"
gpasswd -a ${yourUserName} video
echo -e ""

# Add sudo permissions for your user
# This is the same if you edit the file "/etc/sudoers"
#EDITOR=nano visudo
# And uncomment to allow members of group to execute any command
# %wheel ALL=(ALL) ALL
# This command delete the comment in /etc/sudoers
echo -e "Adding sudo permissions for your user"
sed -i '/%wheel ALL=(ALL) ALL/ s/^##* *//' /etc/sudoers
echo -e ""

echo -e "The sudo password is requested one time per session"
sed -i "\$a\\\n\nDefaults:${yourUserName} timestamp_timeout=-1\n" /etc/sudoers
echo -e ""

echo -e "Disabling WiFi 11n, it fix the slow internet download"
echo -e 'options iwlwifi 11n_disable=1 bt_coex_active=0 power_save=0 auto_agg=0 swcrypto=0' | tee /etc/modprobe.d/iwlwifi.conf
echo -e ""

echo -e "Disabling the power save into the WiFi card"
echo -e 'ACTION=="add", SUBSYSTEM=="net", KERNEL=="wlp2s*", RUN+="/usr/bin/iw dev %k set power_save off"' | tee /etc/udev/rules.d/70-wifi-powersave.rules
echo -e ""


# Move the archLinux project into the user folder.
echo -e "Moving the archLinux project into the user workspace directory"
mkdir -p /home/${yourUserName}/workspace/projects
cd /home/${yourUserName}/workspace/projects
mv /archLinux-installer-and-setup ./
chown -R ${yourUserName} ./archLinux-installer-and-setup
chgrp -R users ./archLinux-installer-and-setup
echo -e ""

echo -e "Set up Git"
git config --global user.name ${yourName}
git config --global user.email ${yourEmail}
./archLinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/05-knowledge/99c-git-alias.sh
echo -e ""

# Exit from Arch change root
echo -e "Exiting from Arch change root"
exit
echo -e ""
