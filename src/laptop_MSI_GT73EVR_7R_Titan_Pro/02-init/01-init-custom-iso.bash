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

funcChangeConsoleFont

# -------------------------- #
# Extract Arch Linux project #
# -------------------------- #

# Clon the git project in your computer.
tar -xzf archLinux-installer-and-setup.tar
cd ./archLinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/

# -------- #
# Finished #
# -------- #

# In the directory 'cd /home/root/workspace/projects/'.
# Go inside 'cd archLinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/'.
# Go to the folder 'cd 03-installer/'.
# and execute the file './01-pre-installation-efi.bash'.
