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

# Go to the ArchLinux project into the user folder.
cd ~/workspace/projects || funcDirectoryNotExist

# ---------- #
# Set up Git #
# ---------- #

# Set up Git.
if [ -z "${1}" ]; then
  echo "ERROR: Expected the user's name for the Git."
  exit 1
elif [ -z "${2}" ]; then
  echo "ERROR: Expected the user's email for the Git."
  exit 1
fi
echo "Git username: ${1}"
echo "Git email: ${2}"
git config --global user.name "${1}"
git config --global user.email "${2}"
./archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/05-knowledge/99c-git-alias.bash

# -------- #
# Finished #
# -------- #

# Exit from logged user.
exit 0
