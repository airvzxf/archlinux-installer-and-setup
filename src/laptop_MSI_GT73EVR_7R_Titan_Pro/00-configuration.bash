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
computerName="laptop-archlinux"
# --------------------------------------------------
countryCode="MX,US"
timezone="America/Mexico_City"
languageCode="en_US.UTF-8"
keyboardLayout="us"
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
# NOTE: Uncomment and change the following values for testing purposes.
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
  # Fonts are located in /usr/share/kbd/consolefonts/.
  setfont "${consoleFont}"
}

# Function which checks if your computer is connected to the Internet.
funcIsConnectedToInternet() {
  echo "Check your Internet connection."
  if ! ping -c 1 google.com >> /dev/null 2>&1; then
    echo "You have problems with your Internet."
    echo "Please check if:"
    echo " — The Internet works properly."
    echo " — The Internet cable is connected to your computer and modem."
    echo " — You have Wi-Fi, please execute this command: 'wifi-menu' and connect to your account."
    echo ""
    exit 1
  fi
  echo "You have the Internet!"
}

# Function to display error and exit when the directory not exists.
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
  if [ -z "${1}" ]; then
    set -- "/etc"
  fi

  local etcDirectory
  etcDirectory="${1}"

  # Enable the multi library repository.
  sed --in-place '/\[multilib\]/,/mirrorlist/ s/^##*//' "${etcDirectory}"/pacman.conf
  # Enable the color output.
  sed --in-place "s/#Color/Color/g" "${etcDirectory}"/pacman.conf
  # Enable the verbose package list.
  sed --in-place "s/#VerbosePkgLists/VerbosePkgLists/g" "${etcDirectory}"/pacman.conf
  # Enable and set the parallel downloads.
  sed --in-place --regexp-extended "s/[#]?ParallelDownloads = 5/ParallelDownloads = 35/g" "${etcDirectory}"/pacman.conf
}

# Umount system in the device which will be installed.
funcUmountSystem() {
  echo "Unmounting the file systems"
  fuser --kill /mnt/archlinux || true
  umount --recursive /mnt/archlinux || true
  swapoff --all
}

# Mount the system in the device which will be installed.
funcMountSystem() {
  funcUmountSystem

  echo "Mounting the file systems"
  mkdir -p /mnt/archlinux
  mount ${hardDiskDeviceArchLinux} /mnt/archlinux
  mount --mkdir ${hardDiskDeviceBoot} /mnt/archlinux/boot/EFI
  swapon ${hardDiskDeviceSwap}
}

# Check if the BIOS is EFI.
funcIsEfiBios() {
  if ! [[ $(ls --almost-all /sys/firmware/efi/efivars) ]]; then
    echo ""
    echo "This script only runs the Arch Linux in EFI BIOS, sorry."
    echo ""
    echo "The script has been FINISHED."
    exit 1
  fi
}

# Install Yay using git.
funcInstallYay() {
  local directory
  directory=~/yay-installation
  rm --force --recursive "${directory}"
  mkdir --parents "${directory}"
  cd "${directory}" || funcDirectoryNotExist
  git clone https://aur.archlinux.org/yay.git
  cd yay || funcDirectoryNotExist
  makepkg --syncdeps --install --needed --noconfirm
  cd ./../../ || funcDirectoryNotExist
  rm --force --recursive "${directory}"
  yay --version
  yay --save --answerclean All --answerdiff None
  yay --sync --noconfirm yay

  return 0
}

# Check if the Pacman mirror list has the expected mirrors.
funcCheckPacmanMirror() {
  local MIRROR_LIST_PATH
  MIRROR_LIST_PATH="/etc/xdg/reflector/reflector.conf"
  if [ -n "${1}" ]; then
    MIRROR_LIST_PATH="${1}"
  fi

  local EXPECTED_ARGUMENT
  EXPECTED_ARGUMENT="--country ${countryCode}"
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

PS4
Line #${LINENO}
BASH_COMMAND: ${BASH_COMMAND}
--------------------------------------------------------------------------------
'
