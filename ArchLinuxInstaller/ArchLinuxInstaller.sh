#!/bin/bash

# ------------------------------------------------------
# Arch Linux :: Install
# ------------------------------------------------------
# https://github.com/israel-alberto-rv/archLinux-installer-and-setup.git

# ------------------------------------------------------
# NOTE
# ------------------------------------------------------
# If the Boot USB with Arch Linux show some error about the sources when you try to instal something, execute this command
pacman -Syy



# ------------------------------------------------------
# Pre-installation
# ------------------------------------------------------

#Set the keyboard layout
loadkeys la-latin1


# Connect to the Internet
# Select your network and write your password
wifi-menu
# Check if your wifi connection works properly
ping -c3 google.com


# Verify the boot mode, if it is EFI.
ls /sys/firmware/efi/efivars

# Check if the motherboard works with EFI
efivar -l


# Update the system clock
timedatectl set-ntp true


# Partition the disks
fdisk -l

# Delete all partitions
# Warning: Be careful with this command, the meaning of this is if you
# looking for clean all your disk and install only Arch Linux, otherwise
# if you have your partition in your disk and you know what are you doing,
# skipt the gdisk.
#cfdisk /dev/sda

# Use gdisk to delete all partitions
# Warning: This example delete all partitions and data from the hard disk,
# then create 3 partitions, first the bios, second the Swap memory
# (cache of the memory ram), third the partition for all your Arch Linux.
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
# If you change the order from the partitions in the gdisk, be careful
# to change the the sda (sda1, sda2, sda3) number in this commands.
mkfs.fat -F32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3
fdisk -l

# Mount the file systems
# Same careful for this commands.
mount /dev/sda3 /mnt
mkdir /mnt/home
mkdir /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi



# ------------------------------------------------------
# Installation
# ------------------------------------------------------

# Select mirrors for the database packages
pacman -S reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-bck
# List of countries
reflector --list-countries
# Generate a list of mirrors for your contry with 10 servers.
reflector --country 'US' --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Download and install the base packages
pacstrap /mnt base base-devel

# Configure the system
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab



# ------------------------------------------------------
# Install Arch Root
# ------------------------------------------------------
# This is interesting when you use this command your emulate the login
# as a root in your new installed partition, every command you run
# will take effects when you reboot your computer and use your new
# user and password to login in your account.

# Go to the mnt partition like a Arch Root user.
arch-chroot /mnt


#Set the keyboard layout
loadkeys la-latin1

# Time zone
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc

# Locale
# Uncommment en_US.UTF-8 UTF-8
nano /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "KEYMAP=la-latin1" > /etc/vconsole.conf

# Hostname
echo "[your_computer_name]" > /etc/hostname
echo "127.0.1.1    localhost.localdomain    [your_computer_name]" >> /etc/hosts

# Install Basic Package
pacman -S wifi-menu dialog grub efibootmgr

# Install EFI into Grub
grub-inatall --tartet=x86_64-efi

# Initramfs
mkinitcpio -p linux

# Config Grub
grub-mkconig -o /boot/grub/grub.cfg

# Root password
passwd

# Create your user
useradd -m -g users -G wheel -s /bin/bash [your_user_name]
passwd [your_password_name]

# Add sudo permissions for your user
# This is the same if you edit the file "nano /etc/sudoers"
EDITOR=nano visudo
# And uncomment to allow members of group to execute any command
# %wheel ALL=(ALL) ALL


# Download this project in your computer because when you reboot
# your computer to the follow steps, you don't have a lot of apps or
# packages, it's better if you have this information.
mkdir /home/[your_user_name]/workspace
cd /home/[your_user_name]/workspace
git clone https://github.com/israel-alberto-rv/archLinux-installer-and-setup.git


# Exit from Arch Root
exit

# Reboot
umount -R /mnt
reboot

# Check app installer script for examples to how config your Arch Linux,
# and install Nvidia, Spotify, Steam, Web browser, Utilities, etc.

# The file is in the same project.
# https://github.com/israel-alberto-rv/archLinux-installer-and-setup.git
