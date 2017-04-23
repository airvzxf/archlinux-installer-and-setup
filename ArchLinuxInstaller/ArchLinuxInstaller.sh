#!/bin/bash

# ------------------------------------------------------
# Arch Linux :: Install
# ------------------------------------------------------

#tar zxvf install-archLinux.tar.gz ./


# FTP Server: ftp.rovisoft.net
# FTP port: 21
# User: archLinux@rovisoft.net
# Pass: ArchLinux830830!
# ./public_html/project/archLinux
# /home4/rovisof1/public_html/project/archLinux

# tar -cjvf archLinuxInstaller.tar.bz2 ArchLinuxInstaller

# wget https://project.rovisoft.net/archLinuxInstaller.tar.bz2
# tar -xjvf archLinuxInstaller.tar.bz2





# ------------------------------------------------------
# Pre-installation
# ------------------------------------------------------

#Set the keyboard layout
loadkeys la-latin1

# Connect to the Internet
./wifi-start.sh
ping -c3 google.com

# Verify the boot mode

ls /sys/firmware/efi/efivars


# Check if the motherboard works with EFI
efivar -l

# Update the system clock
timedatectl set-ntp true

# Partition the disks

fdisk -l

# Delete all partitions
#cfdisk /dev/sda

# Or use gdisk to delete all partitions
gdisk
# -o (delete all)
# - n
#   - 1
#   - [Enter]
#   - +512M
#   - EF00
# - n
#   - 2
#   - [Enter]
#   - +3G
#   - 8200
# - n
#   - 3
#   - [Enter]
#   - [Enter]
#   - 8300
# - w
#   - y

# Format the partitions
mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda3
mkswap /dev/sda2
swapon /dev/sda2
fdisk -l

# Mount the file systems
mount /dev/sda3 /mnt
mkdir /mnt/home
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi


# ------------------------------------------------------
# Installation
# ------------------------------------------------------

# Select Mirrors
pacman -S reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-bck
reflector --country 'United States' --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Download and install the base packages
pacstrap /mnt /base base-devel

# Configure the system
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab



# ------------------------------------------------------
# Arch Root
# ------------------------------------------------------

# Go to the mnt partition like a Arch Root user.
arch-chroot /mnt

#Set the keyboard layout
loadkeys la-latin1

# Time zone
ln -sf /usr/share/zoneinfo/America/New_York/etc/localtime

hwclock --systohc


# Locale
# Uncommment en_US.UTF-8 UTF-8

nano /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "KEYMAP=la-latin1" > /etc/vconsole.conf

# Hostname
echo "WolfMachine" > /etc/hostname
echo "127.0.1.1    localhost.localdomain    WolfMachine" >> /etc/hosts

# Install Basic Package
pacman -S wireless_tools wpa_supplicant grub efibootmgr

# Install EFI into Grub
grub-inatall --tartet=x86_64-efi

# Initramfs
mkinitcpio -p linux

# Config Grub
grub-mkconig -o /boot/grub/grub.cfg

# Root password
passwd

# Create wol user
useradd -m -g users -G wheel -s /bin/bash wolf
passwd wolf
# Uncomment to allow members of group to execute any command
EDITOR=nano visudo
# Copy script for install Xorg and others
#cp setup-wolf.sh /home/wolf/
#chown wolf /home/wolf/setup-wolf.sh

#chgrp users /home/wolf/setup-wolf.sh


# Exit from Arch Root
exit

# Reboot
umount -R /mnt
reboot
