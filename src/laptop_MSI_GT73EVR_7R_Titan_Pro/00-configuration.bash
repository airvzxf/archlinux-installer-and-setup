#!/usr/bin/env bash

# ---------------------------------------------------------------------- #
# Arch Linux :: General configuration                                    #
# ---------------------------------------------------------------------- #
# https://github.com/airvzxf/archlinux-installer-and-setup

# ---------- #
# 00 General #
# ---------- #

userName="Israel Roldan"
userEmail="israel.alberto.rv@gmail.com"
userId="wolf"
computerName="msi-gt73evr-7rf-archlinux-01"
# --------------------------------------------------
countryCode="MX"
timezone="America/Mexico_City"
languageCode="en_US.UTF-8"
keyboardLayout="us"
# --------------------------------------------------
# TODO: Check if I am using this variable. Otherwise, remove it.
# networkInterface="enp0s3" # enp4s0
# --------------------------------------------------
consoleFont="ter-122n"

# -------- #
# 00 Notes #
# -------- #

# The variables with the comment '# (◠‿◠)',
# they could or should be changed with your personal
# preferences.

# WARNING: Change in the section "03 Install ArchLinux" the
# names of the hard disk devices, with the hard disk that
# you will format (erase).

# --------------- #
# 01 Bootable USB #
# --------------- #

archlinuxImageURL="https://arch.jsc.mx/iso/latest/" # (◠‿◠)

archIsoProfile="releng"
archIsoFolder="archlinuxLiveIso"
archIsoFile="archlinux-x86_64.iso"
currentDirectory="$(pwd)"
archIsoDirectory="/home/$(whoami)/${archIsoFolder}"
archIsoFilePath="${archIsoDirectory}/out/${archIsoFile}"

# -------------------- #
# 03 Install ArchLinux #
# -------------------- #

# Set up the variables.
hardDiskDevice="/dev/nvme0n1"             # (◠‿◠)
hardDiskDeviceBoot="/dev/nvme0n1p1"       # (◠‿◠)
hardDiskDeviceSwap="/dev/nvme0n1p2"       # (◠‿◠)
hardDiskDeviceOtherLinux="/dev/nvme0n1p3" # (◠‿◠)
hardDiskDeviceArchLinux="/dev/nvme0n1p4"  # (◠‿◠)
# --------------------------------------------------
# TODO: Delete the below variables of hardDiskDevice
#hardDiskDevice="/dev/sda"            # (◠‿◠)
#hardDiskDeviceBoot="/dev/sda1"       # (◠‿◠)
#hardDiskDeviceSwap="/dev/sda2"       # (◠‿◠)
#hardDiskDeviceOtherLinux="/dev/sda3" # (◠‿◠)
#hardDiskDeviceArchLinux="/dev/sda4"  # (◠‿◠)
# --------------------------------------------------
hardDiskDeviceBootSize="+512M"      # (◠‿◠)
hardDiskDeviceSwapSize="+16G"       # (◠‿◠)
hardDiskDeviceOtherLinuxSize="+35G" # (◠‿◠)
hardDiskDeviceArchLinuxSize=""      # (◠‿◠)

# ------------------- #
# 99 Shared functions #
# ------------------- #

# Function to change the font family of the console.
funcChangeConsoleFont() {
  if [ -n "${1}" ]; then
    consoleFont="${1}"
  fi

  # Fonts are located in /usr/share/kbd/consolefonts/.
  setfont "${consoleFont}"
}

# Function which checks if your computer is connected to Internet.
funcIsConnectedToInternet() {
  echo "Checking your Internet connection."
  if ! ping -c 1 google.com >> /dev/null 2>&1; then
    echo "You have problems with your Internet."
    echo "Please check if:"
    echo " - The Internet works properly."
    echo " - The Internet cable is connected to your computer and modem."
    echo " - You have Wi-Fi please execute this command: 'wifi-menu' and connect in your account."
    echo ""
    exit 1
  fi
  echo "You have Internet!"
}

# Function to display error and exit when the directory not exist.
funcDirectoryNotExist() {
  echo "ERROR: Try to enter a directory that does not exist."
  exit 1
}

# Function to exit if the user does not want to continue.
funcContinue() {
  if ! [[ ${1} =~ ^([yY])+$ ]]; then
    echo "Your choice was not to continue."
    echo ""
    exit 1
  fi
}

# Function to exit if the user does not want to continue. It is default to yes.
funcContinueDefaultYes() {
  if [[ ${1} =~ ^([nN])+$ ]]; then
    echo "Your choice was not to continue."
    echo ""
    exit 1
  fi
}

# Function to change some parameters in the pacman.conf file.
funcSetupPacmanConfiguration() {
  local etcDirectory
  etcDirectory="/etc"
  if [ -n "${1}" ]; then
    etcDirectory="${1}"
  fi

  sed --in-place "s/#Color/Color/g" "${etcDirectory}"/pacman.conf
  sed --in-place "s/#VerbosePkgLists/VerbosePkgLists/g" "${etcDirectory}"/pacman.conf
  sed --in-place --regexp-extended "s/[#]?ParallelDownloads = 5/ParallelDownloads = 15/g" "${etcDirectory}"/pacman.conf
}

# Umount system in the device which will be installed.
funcUmountSystem() {
  echo "Unmounting the file systems"
  fuser --kill /mnt || true
  umount --recursive /mnt || true
  swapoff --all
}

# Mount system in the device which will be installed.
funcMountSystem() {
  funcUmountSystem

  echo "Mounting the file systems"
  mount ${hardDiskDeviceArchLinux} /mnt
  mount --mkdir ${hardDiskDeviceBoot} /mnt/boot/EFI
  swapon ${hardDiskDeviceSwap}
}

# Check if the BIOS is EFI.
funcIsEfiBios() {
  if ! [[ $(ls --almost-all /sys/firmware/efi/efivars) ]]; then
    echo ""
    echo "This script only run the Arch Linux in EFI BIOS, sorry."
    echo ""
    echo "The script has been FINISHED."
    exit 1
  fi
}

# Install Yay using git.
funcInstallYay() {
  local directory
  directory=~/tmp/yay-installation
  mkdir --parents "${directory}"
  cd "${directory}" || funcDirectoryNotExist
  git clone https://aur.archlinux.org/yay.git
  cd yay || funcDirectoryNotExist
  makepkg --syncdeps --install --needed --noconfirm
  cd ./../../ || funcDirectoryNotExist
  rm --force --recursive "${directory}"

  return 0
}

# Check if the Pacman mirror list has the expected mirrors.
funcCheckPacmanMirror() {
  local MIRROR_LIST_PATH
  MIRROR_LIST_PATH="/etc/pacman.d/mirrorlist"
  if [ -n "${1}" ]; then
    MIRROR_LIST_PATH="${1}"
  fi

  local EXPECTED_ARGUMENT
  EXPECTED_ARGUMENT=" --country ${countryCode} "
  grep --color=always -- "${EXPECTED_ARGUMENT}" "${MIRROR_LIST_PATH}" || {
    cat "${MIRROR_LIST_PATH}"
    echo "ERROR: The mirror list does not match the expected mirrors."
    echo "       Please check your reflector command."
    echo "       Expected argument in command: ${EXPECTED_ARGUMENT}."
    echo "       in: ${MIRROR_LIST_PATH}."
    exit 1
  }
}

PS4='

Line #${LINENO}
BASH_COMMAND: ${BASH_COMMAND}
--------------------------------------------------------------------------------
'
