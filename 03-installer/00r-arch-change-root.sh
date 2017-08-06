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
loadkeys $keyboardLayout
echo -e ""

# Set the time zone
echo -e "Setting the time zone"
ln -sf /usr/share/zoneinfo/$zoneInfo /etc/localtime
hwclock --systohc
timedatectl
echo -e ""

# Set the locale
# Uncomment en_US.UTF-8 UTF-8 or find your language and charset
# nano /etc/locale.gen
# This command auto delete the comments in /etc/locale.gen
echo -e "Setting the language and charset into locale"
sed -i '/[^ ]$languageCode UTF-8/ s/^##*//' /etc/locale.gen
locale-gen
echo -e ""

echo -e "Setting the language into locale config"
echo "LANG=$languageCode" > /etc/locale.conf
echo -e ""

echo -e "Setting the keyboard layout into vconsole config"
echo "KEYMAP=$keyboardLayout" > /etc/vconsole.conf
echo -e ""

# Set the hostname
echo -e "Setting the hostname"
echo $yourComputerName > /etc/hostname
funcAddTextAtTheEndOfFile "127.0.1.1    localhost.localdomain    $yourComputerName" /etc/hosts
echo -e ""

# Install basic package
echo -e "Installing basic package: wpa_supplicant dialog grub efibootmgr"
pacman -S --needed --noconfirm wpa_supplicant dialog grub efibootmgr
echo -e ""

# Install EFI into Grub
echo -e "Installing EFI into Grub"
grub-inatall --tartet=x86_64-efi
echo -e ""

# Initramfs, create an initial ramdisk environment
echo -e "Creating an initial ramdisk environment"
mkinitcpio -p linux
echo -e ""

# Config Grub
echo -e "Setting the grub config"
grub-mkconig -o /boot/grub/grub.cfg
echo -e ""

# Change root password
echo -e "Please change your root password:"
passwd
echo -e ""

# Create your user and password
echo -e "Creating your user ($yourUserName)"
useradd -m -g users -G wheel -s /bin/bash $yourUserName
echo -e ""

echo -e "Please change your user password:"
passwd $yourUserName
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

# Exit from Arch change root
echo -e "Exiting from Arch change root"
exit
echo -e ""
