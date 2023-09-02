#!/usr/bin/env bash
set -ve

# ---------------------------------------------------------------------- #
# Arch Linux :: Install inside of the Arch Change Root                   #
# ---------------------------------------------------------------------- #
# https://github.com/airvzxf/archlinux-installer-and-setup

# ---------------- #
# ARCH CHANGE ROOT #
# ---------------- #

cd /archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/03-installer/ || funcDirectoryNotExist

source ./../00-configuration.bash

# shellcheck disable=SC2119
funcChangeConsoleFont

# ------------- #
# Set up Pacman #
# ------------- #

# shellcheck disable=SC2119
funcSetupPacmanConfiguration

# shellcheck disable=SC2119
funcCheckPacmanMirror

# Update the database sources in Arch Linux.
pacman --sync --refresh --refresh --noconfirm

# Ensure the Pacman keyring is properly initialized.
pacman-key --init

# -------------------------- #
# Install the basic packages #
# -------------------------- #

# Install Operative system tools.
# -------------------------------
# Install the GNU GRand Unified Bootloader.
pacman --sync --needed --noconfirm grub
# Install the Linux user-space application to modify the EFI Boot Manager.
pacman --sync --needed --noconfirm efibootmgr
# Install the DOS filesystem utilities.
pacman --sync --needed --noconfirm dosfstools
# Install the utility to detect other OSes on a set of drives.
pacman --sync --needed --noconfirm os-prober
# Install a collection of utilities to access MS-DOS disks.
pacman --sync --needed --noconfirm mtools
# Install the Vi Improved, a highly configurable, improved version of the vi text editor.

# Install user tools.
# -------------------
pacman --sync --needed --noconfirm vim
# Install the fast distributed version control system.
pacman --sync --needed --noconfirm git
# Install the programmable completion for the bash shell.
pacman --sync --needed --noconfirm bash-completion
# Install the record and share terminal sessions.
pacman --sync --needed --noconfirm asciinema
# Install the Cat clone with syntax highlighting and git integration.
pacman --sync --needed --noconfirm bat

# ------------------- #
# Set up the generals #
# ------------------- #

# Create Vim folder.
mkdir -p /root/.vim

# Set up the keyboard layout.
loadkeys "${keyboardLayout}"

# Set up the time zone.
ln --symbolic --force /usr/share/zoneinfo/"${timezone}" /etc/localtime
hwclock --systohc
date

# Set up the language and charset into locale.
sed --in-place "/[^ ]${languageCode} UTF-8/ s/^##*//" /etc/locale.gen
locale-gen

# Set up the language into locale config.
echo "LANG=${languageCode}" > /etc/locale.conf

# Set up the vconsole configuration file.
echo "KEYMAP=${keyboardLayout}" > /etc/vconsole.conf
echo "FONT=${consoleFont}" >> /etc/vconsole.conf

# Set up the hostname.
echo "${computerName}" > /etc/hostname

# Set up the hosts.
echo "127.0.0.1    localhost" >> /etc/hosts
echo "::1          localhost" >> /etc/hosts

# Set up the Ethernet connection
echo '[Match]
Name=en*
Name=eth*

[Network]
DHCP=yes
MulticastDNS=yes
IPv6PrivacyExtensions=yes

[DHCPv4]
RouteMetric=100

[IPv6AcceptRA]
RouteMetric=100
' | tee /usr/lib/systemd/network/50-ethernet.network

# Set up the Wi-Fi connection
echo '[Match]
Name=wl*

[Network]
DHCP=yes
MulticastDNS=yes
IPv6PrivacyExtensions=yes

[DHCPv4]
RouteMetric=600

[IPv6AcceptRA]
RouteMetric=600
' | tee /usr/lib/systemd/network/50-wlan.network

# Set up the Mobile connection
echo '[Match]
Name=ww*

[Network]
DHCP=yes
IPv6PrivacyExtensions=yes

[DHCPv4]
RouteMetric=700

[IPv6AcceptRA]
RouteMetric=700
' | tee /usr/lib/systemd/network/50-wwan.network

# Enable the system services for network.
ln --symbolic /usr/lib/systemd/system/systemd-networkd.service /usr/lib/systemd/system/multi-user.target.wants/systemd-networkd.service

# Enable the system services for network resolved.
ln --symbolic /usr/lib/systemd/system/systemd-resolved.service /usr/lib/systemd/system/multi-user.target.wants/systemd-resolved.service

# Create a script to enable the number lock in the keyboard.
echo '#!/bin/bash

for tty in /dev/tty{1..6}
do
    /usr/bin/setleds -D +num < "$tty";
done
' | tee /usr/local/bin/numlock

# Make this script executable.
chmod +x /usr/local/bin/numlock

# Create the system service for enable of the number lock.
echo '[Unit]
Description=numlock

[Service]
ExecStart=/usr/local/bin/numlock
StandardInput=tty
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
' | tee /usr/lib/systemd/system/numlock.service

# Enable the system services for enable of the number lock.
ln --symbolic /usr/lib/systemd/system/numlock.service /usr/lib/systemd/system/multi-user.target.wants/numlock.service

# -------------------------- #
# Set up Grub configurations #
# -------------------------- #

# Install EFI into Grub.
grub-install --target x86_64-efi --bootloader-id grub_uefi --recheck

# Change the initial timeout from 5 to 1 second.
sed --in-place 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub

# Change the default command line of Grub.
#sed --in-place 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet video.use_native_backlight=1"/g' /etc/default/grub

# Create the grub config file.
grub-mkconfig --output /boot/grub/grub.cfg

# ----------------- #
# Set up Mkinitcpio #
# ----------------- #

# Install the firmware files for Linux - qlogic / Firmware for QLogic devices.
pacman --sync --needed --noconfirm linux-firmware-qlogic

# Create an initial ramdisk environment.
mkinitcpio --preset linux

# ---------------------------- #
# Set up users and permissions #
# ---------------------------- #

# Set up the root password.
#passwd

# Create a new user.
useradd --create-home --gid users --groups wheel,storage,power --shell /bin/bash "${userId}"

# Set up the user password.
passwd "${userId}"

# Add your user to the video group.
gpasswd --add "${userId}" video

# Allow members of group to execute any command.
sed --in-place '/%wheel ALL=(ALL:ALL) ALL/ s/^##* *//' /etc/sudoers

# The sudo password is requested one time per session.
echo '
# Once the password is entered in the console, it is not requesting anymore.
Defaults:'"${userId}"' timestamp_timeout=-1
' | tee --append /etc/sudoers

# Disable Wi-Fi 11n, it fixes the slow internet download.
#echo 'options iwlwifi 11n_disable=1 bt_coex_active=0 power_save=0 auto_agg=0 swcrypto=0' | tee /etc/modprobe.d/iwlwifi.conf

# Disable the power save into the Wi-Fi card.
#echo 'ACTION=="add", SUBSYSTEM=="net", KERNEL=="wlp2s*", RUN+="/usr/bin/iw dev %k set power_save off"' | tee /etc/udev/rules.d/70-wifi-powersave.rules

# Move configuration files from the project to the user folder.
cp --recursive /archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/04-setup/setup-resources/. /home/"${userId}"/
chown --recursive "${userId}":users /home/"${userId}"/.

# -------------------- #
# Log in with the user #
# -------------------- #

# Login as the user.
cp ./99-user-setup.bash /home/"${userId}"/
chmod +x /home/"${userId}"/99-user-setup.bash
chown "${userId}":users /home/"${userId}"/99-user-setup.bash

su --login -c "export userName='${userName}' userEmail='${userEmail}'; /home/${userId}/99-user-setup.bash" "${userId}"

rm --force /home/"${userId}"/99-user-setup.bash

# -------- #
# Finished #
# -------- #

# Exit from Arch change root
exit 0
