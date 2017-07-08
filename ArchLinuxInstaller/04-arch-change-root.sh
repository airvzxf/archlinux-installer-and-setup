#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Install
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Arch Change Root
# ----------------------------------------------------------------------
# This is interesting, this command emulate your the login session
# as a root in your new installed partition, every command you run
# will take effects when you reboot your computer and use your new
# user and password to login in your account.

# Go to the main Linux partition like a root user.
arch-chroot /mnt

#Set the keyboard layout
loadkeys "$keyboardLayout"

# Time zone
ln -sf /usr/share/zoneinfo/"$zoneInfo" /etc/localtime
hwclock --systohc

# Locale
# Uncomment en_US.UTF-8 UTF-8 or find your language and charset
nano /etc/locale.gen
locale-gen
echo "LANG=$languageCode" > /etc/locale.conf
echo "KEYMAP=$keyboardLayout" > /etc/vconsole.conf

# Hostname
echo "$yourComputerName" > /etc/hostname
echo "127.0.1.1    localhost.localdomain    $yourComputerName" >> /etc/hosts

# Install Basic Package
pacman -S wpa_supplicant dialog grub efibootmgr

# Install EFI into Grub
grub-inatall --tartet=x86_64-efi

# Initramfs, detect your hardware and install the common drivers 
mkinitcpio -p linux

# Config Grub
grub-mkconig -o /boot/grub/grub.cfg

# Change root password
passwd

# Create your user and password
useradd -m -g users -G wheel -s /bin/bash "$yourUserName"
passwd "$yourUserName"

# Add sudo permissions for your user
# This is the same if you edit the file "nano /etc/sudoers"
EDITOR=nano visudo
# And uncomment to allow members of group to execute any command
# %wheel ALL=(ALL) ALL

# Exit from Arch change root
exit

# Reboot
umount -R /mnt
reboot

# Check the Arch Linux setup scripts config your Arch Linux and install
# apps like as Nvidia, Web browser, Utilities, Spotify, Steam, etc.
