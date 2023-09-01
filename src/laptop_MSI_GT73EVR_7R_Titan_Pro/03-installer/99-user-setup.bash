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
# TODO: since it is logged with the user, these two lines are not necessary.
ls -lhaR ~/
sleep 10
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
# TODO: An error displayed when execute this line. The error is related to root stuff.
./archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/05-knowledge/99c-git-alias.bash
# TODO: Check if all is correct.
sleep 10

# -------- #
# Finished #
# -------- #

# Exit from logged user.
exit 0
