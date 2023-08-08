#!/usr/bin/env bash
set -ve

# ---------------------------------------------------------------------- #
# Arch Linux :: Init                                                     #
# ---------------------------------------------------------------------- #
# https://github.com/airvzxf/archlinux-installer-and-setup

# -------------------------------- #
# INIT THE ARCH LINUX INSTALLATION #
# -------------------------------- #

source ./../00-configuration.bash

# shellcheck disable=SC2119
funcChangeConsoleFont

# -------------------------- #
# Extract Arch Linux project #
# -------------------------- #

# Clone the git project in your computer.
tar --extract --gzip --file archlinux-installer-and-setup.tar
cd ./archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/ || funcDirectoryNotExist

# -------- #
# Finished #
# -------- #

# In the directory 'cd /home/root/workspace/projects/'.
# Go inside 'cd archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/'.
# Go to the folder 'cd 03-installer/'.
# and execute the file './01-pre-installation-efi.bash'.
