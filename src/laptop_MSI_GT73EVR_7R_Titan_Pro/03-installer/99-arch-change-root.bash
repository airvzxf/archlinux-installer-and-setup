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

funcChangeConsoleFont

# ------------- #
# Set up Pacman #
# ------------- #

funcSetupPacmanConfiguration

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
# Install the Linux user-space application to modify the EFI Boot Manager.
# Install the DOS filesystem utilities.
# Install the utility to detect other OSes on a set of drives.
# Install a collection of utilities to access MS-DOS disks.
# -------------------
# Install user tools.
# -------------------
# Install a terminal-based program for viewing text files.
# Install the Cat clone with syntax highlighting and git integration.
# Install the Vi Improved, a highly configurable, improved version of the vi text editor.
# Install the programmable completion for the bash shell.
# Install the record and share terminal sessions.
# Install the fast distributed version control system.
# -------------------
# Install firmwares
# -------------------
# Install the firmware files for Linux - qlogic / Firmware for QLogic devices.
pacman --sync --needed --noconfirm \
  grub efibootmgr dosfstools os-prober mtools \
  less bat vim bash-completion asciinema git \
  linux-firmware-qlogic

# Create an initial ramdisk environment.
# NOTE: This step is not necessary because the above firmware executed the mkinitcpio.
#mkinitcpio --preset linux

# ------------------- #
# Set up the generals #
# ------------------- #

# Create Vim folder.
mkdir --parents /root/.vim

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
echo "LANG=${languageCode}" >/etc/locale.conf

# Set up the vconsole configuration file.
echo "KEYMAP=${keyboardLayout}" >/etc/vconsole.conf
echo "FONT=${consoleFont}" >>/etc/vconsole.conf

# ------------------ #
# Set up the network #
# ------------------ #

# Set up the hostname.
echo "${computerName}" >/etc/hostname

# Set up the hosts.
echo "127.0.0.1    localhost" >>/etc/hosts
echo "::1          localhost" >>/etc/hosts

# Set up the Ethernet connection
echo "[Match]
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

[Route]
InitialCongestionWindow=${networkInitialCongestionWindow}
InitialAdvertisedReceiveWindow=${networkInitialAdvertisedReceiveWindow}
" | tee /usr/lib/systemd/network/50-ethernet.network

# Set up the Wi-Fi connection
echo "[Match]
Name=wl*

[Network]
DHCP=yes
MulticastDNS=yes
IPv6PrivacyExtensions=yes

[DHCPv4]
RouteMetric=600

[IPv6AcceptRA]
RouteMetric=600
" | tee /usr/lib/systemd/network/50-wlan.network

# Set up the Mobile connection
echo "[Match]
Name=ww*

[Network]
DHCP=yes
IPv6PrivacyExtensions=yes

[DHCPv4]
RouteMetric=700

[IPv6AcceptRA]
RouteMetric=700
" | tee /usr/lib/systemd/network/50-wwan.network

# Enable the system service for network.
ln --symbolic /usr/lib/systemd/system/systemd-networkd.service /usr/lib/systemd/system/multi-user.target.wants/systemd-networkd.service

# Enable the system service for network resolved.
ln --symbolic /usr/lib/systemd/system/systemd-resolved.service /usr/lib/systemd/system/multi-user.target.wants/systemd-resolved.service

# ---------------------- #
# Set up the number lock #
# ---------------------- #

# Create a script to enable the number lock in the keyboard.
echo "#!/bin/bash

for tty in /dev/tty{1..6}
do
    /usr/bin/setleds -D +num < \"\$tty\";
done
" | tee /usr/local/bin/numlock

# Make this script executable.
chmod +x /usr/local/bin/numlock

# Create the system service for enabling of the number lock.
echo "[Unit]
Description=numlock

[Service]
ExecStart=/usr/local/bin/numlock
StandardInput=tty
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
" | tee /usr/lib/systemd/system/numlock.service

# Enable the system service for enabling of the number lock.
ln --symbolic /usr/lib/systemd/system/numlock.service /usr/lib/systemd/system/multi-user.target.wants/numlock.service

# -------------------------------- #
# Set up the automatic user log in #
# -------------------------------- #

# Create the folder.
mkdir --parents /etc/systemd/system/getty@tty1.service.d/

# Create the system service for log-in automatically.
echo "[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin ${userId} %I ${TERM}
" | tee /etc/systemd/system/getty@tty1.service.d/autologin.conf

# ----------------------------- #
# Set up the laptop lid actions #
# ----------------------------- #

sed --in-place '/HandleLidSwitch=/ s/#*/#/' /etc/systemd/logind.conf

echo "
# Prevent suspending when the lid is closing.
HandleLidSwitch=ignore
" | tee --append /etc/systemd/logind.conf

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

# Allow members of the group wheel can execute any command.
sed --in-place '/%wheel ALL=(ALL:ALL) ALL/ s/^##* *//' /etc/sudoers

# The sudo password is requested one time per session.
echo "
# Enable the user to power off the computer.
\"${userId}\" ALL=NOPASSWD:/sbin/poweroff

# Enable the user to reboot the computer.
\"${userId}\" ALL=NOPASSWD:/sbin/reboot

# Once the password is entered in the console, it is not requested anymore.
Defaults:\"${userId}\" timestamp_timeout=-1
" | tee --append /etc/sudoers

# Disable Wi-Fi 11n, it fixes the slow internet download.
#echo "options iwlwifi 11n_disable=1 bt_coex_active=0 power_save=0 auto_agg=0 swcrypto=0" | tee /etc/modprobe.d/iwlwifi.conf

# Disable the power save into the Wi-Fi card.
#echo "ACTION==\"add\", SUBSYSTEM==\"net\", KERNEL==\"wlp2s*\", RUN+=\"/usr/bin/iw dev %k set power_save off\"" | tee /etc/udev/rules.d/70-wifi-powersave.rules

# Copy configuration files from the project to the user folder.
cp --recursive /archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/04-setup/setup-resources/. /home/"${userId}"/
chown --recursive "${userId}":users /home/"${userId}"/.

# -------------------- #
# Log in with the user #
# -------------------- #

# Copy the script for the user setup.
cp ./99-user-setup.bash /home/"${userId}"/
chmod +x /home/"${userId}"/99-user-setup.bash
chown "${userId}":users /home/"${userId}"/99-user-setup.bash

# Create the ArchLinux project into the user folder.
mkdir --parents /home/"${userId}"/workspace/projects

# Copy the project to the user folder.
cp --recursive /archlinux-installer-and-setup /home/"${userId}"/workspace/projects

# Change the workspace directory owner and group to the user.
chown --recursive "${userId}":users /home/"${userId}"/workspace

# Log in with the user.
su --login -c "/home/${userId}/99-user-setup.bash '${userName}' '${userEmail}'" "${userId}"

# Remove the script for the user setup.
rm --force /home/"${userId}"/99-user-setup.bash

# -------- #
# Finished #
# -------- #

# Exit from Arch change root
exit 0
