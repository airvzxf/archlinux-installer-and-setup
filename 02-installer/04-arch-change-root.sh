#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Install
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Arch Change Root
# ----------------------------------------------------------------------
# This interesting command emulate that you are login in the mount device
# and every command affect your session, that's the meaning if you config
# your language, timezone, keyboard, etc., it will take effects when you
# reboot and login in without the USB bootloader.

# Go to the main Linux partition like a root user.
arch-chroot /mnt

# Set the keyboard layout
loadkeys "$keyboardLayout"

# Set the time zone
ln -sf /usr/share/zoneinfo/"$zoneInfo" /etc/localtime
hwclock --systohc

# Set the locale
# Uncomment en_US.UTF-8 UTF-8 or find your language and charset
nano /etc/locale.gen
locale-gen
echo "LANG=$languageCode" > /etc/locale.conf
echo "KEYMAP=$keyboardLayout" > /etc/vconsole.conf

# Set the hostname
echo "$yourComputerName" > /etc/hostname
echo "127.0.1.1    localhost.localdomain    $yourComputerName" >> /etc/hosts

# Install basic package
pacman -S wpa_supplicant dialog grub efibootmgr

# Install EFI into Grub
grub-inatall --tartet=x86_64-efi

# Initramfs, create an initial ramdisk environment
mkinitcpio -p linux

# Config Grub
grub-mkconig -o /boot/grub/grub.cfg

# Change root password
passwd

# Create your user and password
useradd -m -g users -G wheel -s /bin/bash "$yourUserName"
passwd "$yourUserName"

# Add sudo permissions for your user
# This is the same if you edit the file "/etc/sudoers"
EDITOR=nano visudo
# And uncomment to allow members of group to execute any command
# %wheel ALL=(ALL) ALL

# Exit from Arch change root
exit

# Reboot
umount -R /mnt
reboot

# Check the Arch Linux setup scripts to install apps like as Nvidia,
# Web browser, Utilities, Spotify, Steam, etc.
