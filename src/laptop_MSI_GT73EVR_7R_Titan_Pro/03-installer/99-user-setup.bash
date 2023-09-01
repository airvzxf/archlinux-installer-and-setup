#!/usr/bin/env bash
set -ve

# ---------------------------------------------------------------------- #
# Arch Linux :: Install inside of the Arch Change Root                   #
# ---------------------------------------------------------------------- #
# https://github.com/airvzxf/archlinux-installer-and-setup

# ----------- #
# USER SET UP #
# ----------- #

# Create Vim folder.
mkdir -p ~/.vim

# -------------------------- #
# Create workspace directory #
# -------------------------- #

# Move the ArchLinux project into the user folder.
mkdir --parents ~/workspace/projects
cd ~/workspace/projects || funcDirectoryNotExist

# ------------------------ #
# Clone Arch Linux project #
# ------------------------ #

git clone https://github.com/airvzxf/archlinux-installer-and-setup.git

# ---------- #
# Set up Git #
# ---------- #

# Set up Git.
git config --global user.name "${userName}"
git config --global user.email "${userEmail}"
./archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/05-knowledge/99c-git-alias.bash

# -------- #
# Finished #
# -------- #

# Exit from logged user.
exit 0
