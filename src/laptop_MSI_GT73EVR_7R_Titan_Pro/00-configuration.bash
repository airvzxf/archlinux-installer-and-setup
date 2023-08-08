#!/usr/bin/env bash

# ---------------------------------------------------------------------- #
# Arch Linux :: General configuration                                    #
# ---------------------------------------------------------------------- #
# https://github.com/airvzxf/archLinux-installer-and-setup

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
networkInterface="enp0s3" # enp4s0
# --------------------------------------------------
consoleFont="ter-122n"

# -------- #
# 00 Notes #
# -------- #

# The variables with the comment '# (◠‿◠)',
# they could or should be change with your personal
# preferences.

# Change in the section '03 Install ArchLinux' the
# names of the hard disk devices, with the hard disk that
# you will format (erease).

# --------------- #
# 01 Bootable USB #
# --------------- #

archlinuxImageURL="https://arch.jsc.mx/iso/latest/" # (◠‿◠)

archisoProfile="releng"
archisoFolder="archLinuxLiveIso"
archisoFile="archlinux-x86_64.iso"
currentDirectory="$(pwd)"
archisoDirectory="/home/$(whoami)/${archisoFolder}"
archisoFilePath="${archisoDirectory}/out/${archisoFile}"

# -------------------- #
# 03 Install ArchLinux #
# -------------------- #

# Set up the variables.
hardDiskDevice="/dev/nvme0n1" # (◠‿◠)
hardDiskDeviceBoot="/dev/nvme0n1p1" # (◠‿◠)
hardDiskDeviceSwap="/dev/nvme0n1p2" # (◠‿◠)
hardDiskDeviceOtherLinux="/dev/nvme0n1p3" # (◠‿◠)
hardDiskDeviceArchLinux="/dev/nvme0n1p4" # (◠‿◠)
# --------------------------------------------------
# TODO: Delete the below variables of hardDiskDevice
hardDiskDevice="/dev/sda" # (◠‿◠)
hardDiskDeviceBoot="/dev/sda1" # (◠‿◠)
hardDiskDeviceSwap="/dev/sda2" # (◠‿◠)
hardDiskDeviceOtherLinux="/dev/sda3" # (◠‿◠)
hardDiskDeviceArchLinux="/dev/sda4" # (◠‿◠)
# --------------------------------------------------
hardDiskDeviceBootSize="+512M" # (◠‿◠)
hardDiskDeviceSwapSize="+16G" # (◠‿◠)
hardDiskDeviceOtherLinuxSize="+35G" # (◠‿◠)
hardDiskDeviceArchLinuxSize="" # (◠‿◠)

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
    echo " - You have wifi please execute this command: 'wifi-menu' and connect in your account."
    echo ""
    exit 1
  fi
  echo "You have Internet!"
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

# Function to change the Pacman.conf file.
funcSetupPacmanConfiguration() {
  etcDirectory="/etc"
  if [ -n "${1}" ]; then
    etcDirectory="${1}"
  fi

  sed -i "s/#Color/Color/g" "${etcDirectory}"/pacman.conf
  sed -i "s/#VerbosePkgLists/VerbosePkgLists/g" "${etcDirectory}"/pacman.conf
  sed -i -E "s/[#]?ParallelDownloads = 5/ParallelDownloads = 15/g" "${etcDirectory}"/pacman.conf
}

# Function to install Pacman package and dependencies.
funcInstallPacmanPackageAndDependencies() {
  package="${1}"
  echo "Package: ${package}"

  previousPackages="${2}"
  echo "Previous packages: ${previousPackages}"

  if [ -z "${package}" ]; then
    echo "The argument '${1}' is empty."
    return 1
  fi

  echo "Install ${package}"
  sudo pacman -S --needed --noconfirm "${package}"
  previousPackages="${2} ${1}"

  getOptionalPackages=$(pacman -Qi "${package}" | sed -n '/^Optional/,$p' | sed '/^Required/q' | head -n -1 | cut -c19- | cut -d: -f1 | cut -d' ' -f1)
  echo "Get optional packages:"
  echo "${getOptionalPackages}"

  while IFS= read -r optionalPackage
  do
    echo "Optional package: ${optionalPackage}"
    if [[ "${optionalPackage}" == "None" ]]; then
      continue
    fi

    pacman -Qi "${optionalPackage}" || {
      sudo pacman -S --asdeps --needed --noconfirm "${optionalPackage}"
      echo "Search for more optional packages: ${optionalPackage}"
      funcInstallPacmanPackageAndDependencies "${optionalPackage}"
    }

  done <<< "${getOptionalPackages}"
}

# Umount system in the device which will be installed.
funcUmountSystem() {
  echo "Umounting the file systems"
  fuser -k /mnt || true
  umount -R /mnt || true
  swapoff -a
}

# Mount system in the device which will be installed.
funcMountSystem() {
  funcUmountSystem

  echo "Mounting the file systems"
  mount ${hardDiskDeviceArchLinux} /mnt
  mount --mkdir ${hardDiskDeviceBoot} /mnt/boot/EFI
  swapon ${harDiskDeviceSwap}
}

# Check if the BIOS is EFI.
funcIsEfiBios() {
  if ! [[ $(ls -A /sys/firmware/efi/efivars) ]]; then
    echo ""
    echo "This script only run the Arch Linux in EFI BIOS, sorry."
    echo ""
    echo "The script has been FINISHED."
    exit 1
  fi
}

# Install Yay using git.
funcInstallYay() {
  directory=~/temp/yay-installation
  mkdir -p "${directory}"
  cd "${directory}"
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --needed --noconfirm
  cd ./../../
  rm -fR "${directory}"

  return 0
}

# Check if the Pacman mirror list has the expected mirrors.
funcCheckPacmanMirror() {
  MIRRORLIST_PATH="/etc/pacman.d/mirrorlist"
  if [ -n "${1}" ]; then
    MIRRORLIST_PATH="${1}"
  fi

  EXPECTED_ARGUMENT=" --country ${countryCode} "
  grep --color=always -- "${EXPECTED_ARGUMENT}" "${MIRRORLIST_PATH}" || {
    cat "${MIRRORLIST_PATH}"
    echo "ERROR: The mirror list does not match the expected mirrors."
    echo "       Please check your reflector command."
    echo "       Expected argument in command: ${EXPECTED_ARGUMENT}."
    echo "       in: ${MIRRORLIST_PATH}."
    exit 1
  }
}

PS4=\
'

Line #${LINENO}
BASH_COMMAND: ${BASH_COMMAND}
--------------------------------------------------------------------------------
'
