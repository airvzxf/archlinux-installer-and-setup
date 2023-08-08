#!/usr/bin/env bash
set -ve

# ---------------------------------------------------------------------- #
# Arch Linux :: Init                                                     #
# ---------------------------------------------------------------------- #
# https://github.com/airvzxf/archLinux-installer-and-setup

# -------------------------------- #
# INIT THE ARCH LINUX INSTALLATION #
# -------------------------------- #

source ./00-configuration.bash

funcIsConnectedToInternet

# ------------- #
# Set up Pacman #
# ------------- #

funcSetupPacmanConfiguration
sed -i -E "s/SigLevel \s?= Required DatabaseOptional/SigLevel = Never TrustAll/g" /etc/pacman.conf

# Stop the automatic system service that updates the mirror list with Reflector. 
systemctl disable --now reflector

# Back up the mirror list of Pacman.
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup-"$(date +%Y-%m-%d-%H-%M-%S-%N)"

# Set the mirror list of Pacman.
reflector --verbose --score 10 --sort score --protocol https --completion-percent 95 --country "${countryCode}" --connection-timeout 600 --save /etc/pacman.d/mirrorlist

funcCheckPacmanMirror

# Update the database sources in Arch Linux.
pacman --noconfirm -Syy

# Ensure the Pacman keyring is properly initialized.
pacman-key --init

# ---------------------------- #
# Install packages with Pacman #
# ---------------------------- #

# Install the monospace bitmap font (for X11 and console).
pacman -S --needed --noconfirm terminus-font
funcChangeConsoleFont
# Install the fast distributed version control system.
pacman -S --needed --noconfirm git
# Install the Vi Improved, a highly configurable, improved version of the vi text editor.
pacman -S --needed --noconfirm vim
# Install a Python 3 module and script to retrieve and filter the latest Pacman mirror list.
pacman -S --needed --noconfirm reflector
# Install the record and share terminal sessions.
pacman -S --needed --noconfirm asciinema

# -------------------------- #
# Extract Arch Linux project #
# -------------------------- #

# Cleaning the older downloaded project.
rm -fR ~/workspace/projects/archLinux-installer-and-setup*

# Create workspace and projects direcotory.
mkdir -p ~/workspace/projects
cd ~/workspace/projects

# Clone the git project in your computer.
git clone https://github.com/airvzxf/archLinux-installer-and-setup.git
cd ./archLinux-installer-and-setup/

# -------- #
# Finished #
# -------- #

# In the directory 'cd /home/root/workspace/projects/'.
# Go inside 'cd archLinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/'.
# Go to the folder 'cd 03-installer/'.
# and execute the file './01-pre-installation-efi.bash'.
