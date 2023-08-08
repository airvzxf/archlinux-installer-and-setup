#!/usr/bin/env bash
set -ve

# ---------------------------------------------------------------------- #
# Arch Linux :: Install inside of the Arch Change Root                   #
# ---------------------------------------------------------------------- #
# https://github.com/airvzxf/archLinux-installer-and-setup

# ---------------- #
# ARCH CHANGE ROOT #
# ---------------- #

source /00-configuration.bash

funcChangeConsoleFont

# ------------- #
# Set up Pacman #
# ------------- #

funcSetupPacmanConfiguration

funcCheckPacmanMirror

# Update the database sources in Arch Linux.
pacman --noconfirm -Syy

# Ensure the Pacman keyring is properly initialized.
pacman-key --init

# -------------------------- #
# Install the basic packages #
# -------------------------- #

# Install Operative system tools.
# -------------------------------
# Install the GNU GRand Unified Bootloader.
pacman -S --needed --noconfirm grub
# Install the Linux user-space application to modify the EFI Boot Manager.
pacman -S --needed --noconfirm efibootmgr
# Install the DOS filesystem utilities.
pacman -S --needed --noconfirm dosfstools
# Install the utility to detect other OSes on a set of drives.
pacman -S --needed --noconfirm os-prober
# Install a collection of utilities to access MS-DOS disks.
pacman -S --needed --noconfirm mtools
# Install the Vi Improved, a highly configurable, improved version of the vi text editor.

# Install user tools.
# -------------------
pacman -S --needed --noconfirm vim
# Install the fast distributed version control system.
pacman -S --needed --noconfirm git
# Install the programmable completion for the bash shell.
pacman -S --needed --noconfirm bash-completion
# Install the record and share terminal sessions.
pacman -S --needed --noconfirm asciinema
# Install the Cat clone with syntax highlighting and git integration.
pacman -S --needed --noconfirm bat

# ------------------- #
# Set up the generals #
# ------------------- #

# Set up the keyboard layout.
loadkeys "${keyboardLayout}"

# Set up the time zone.
ln -sf /usr/share/zoneinfo/America/Mexico_City /etc/localtime
hwclock --systohc
date

# Set up the language and charset into locale.
sed -i "/[^ ]${languageCode} UTF-8/ s/^##*//" /etc/locale.gen
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
echo \
'[Match]
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
echo \
'[Match]
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
echo \
'[Match]
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

# Download and set the Git prompt.
curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh

# -------------------------- #
# Set up Grub configurations #
# -------------------------- #

# Install EFI into Grub.
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck

# Change the initial timeout from 5 to 1 second.
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/g' /etc/default/grub

# Change the default command line of Grub.
#sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet video.use_native_backlight=1"/g' /etc/default/grub

# Create the grub config file.
grub-mkconfig -o /boot/grub/grub.cfg

# ----------------- #
# Set up Mkinitcpio #
# ----------------- #

# Mkinitcpio: Possibly missing firmware for module XXXX.
# ------------------------------------------------------
# Install the firmware files for Linux - qlogic / Firmware for QLogic devices.
pacman -S --needed --noconfirm linux-firmware-qlogic

# Initramfs, create an initial ramdisk environment.
mkinitcpio -p linux

# ---------------------------- #
# Set up users and permissions #
# ---------------------------- #

# Set up the root password.
passwd

# Create a new user.
useradd -m -g users -G wheel,storage,power -s /bin/bash "${userId}"

# Set up the user password.
passwd "${userId}"

# Add your user to the video group.
gpasswd -a "${userId}" video

# Allow members of group to execute any command.
sed -i '/%wheel ALL=(ALL:ALL) ALL/ s/^##* *//' /etc/sudoers

# The sudo password is requested one time per session.
echo \
'
# Once the password is enterd in the console, it is not requesting anymore.
Defaults:'"${userId}"' timestamp_timeout=-1
' | tee -a /etc/sudoers

# Disable WiFi 11n, it fix the slow internet download.
#echo 'options iwlwifi 11n_disable=1 bt_coex_active=0 power_save=0 auto_agg=0 swcrypto=0' | tee /etc/modprobe.d/iwlwifi.conf

# Disable the power save into the WiFi card.
#echo 'ACTION=="add", SUBSYSTEM=="net", KERNEL=="wlp2s*", RUN+="/usr/bin/iw dev %k set power_save off"' | tee /etc/udev/rules.d/70-wifi-powersave.rules

# Move configuration files from the project to the user folder.
cp -R /archLinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/04-setup/setup-resources/. /home/"${userId}"/
chown -R "${userId}":users /home/"${userId}"/.

# Download and set the Git prompt for the user.
curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > /home/"${userId}"/.git-prompt.sh
chown -R "${userId}":users /home/"${userId}"/.git-prompt.sh

# ----------------------- #
# Copy Arch Linux project #
# ----------------------- #

# Move the ArchLinux project into the user folder.
mkdir -p /home/"${userId}"/workspace/projects
cd /home/"${userId}"/workspace/projects
mv /archLinux-installer-and-setup ./
chown -R "${userId}" ./archLinux-installer-and-setup
chgrp -R users ./archLinux-installer-and-setup

# ---------- #
# Set up Git #
# ---------- #

# Set up Git.
git config --global user.name "${userName}"
git config --global user.email "${userEmail}"
./archLinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/05-knowledge/99c-git-alias.bash

# -------- #
# Finished #
# -------- #

# Exit from Arch change root
exit 0
