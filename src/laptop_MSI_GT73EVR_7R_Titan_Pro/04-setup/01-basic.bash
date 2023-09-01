#!/usr/bin/env bash
set -ve

# ----------------------------------------------------------------------
# Arch Linux :: Set up - Basic
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

# ----------------------------------------- #
# BASIC SET UP AFTER ARCHLINUX INSTALLATION #
# ----------------------------------------- #

source ./../00-configuration.bash

funcIsConnectedToInternet

# ------------- #
# Documentation #
# ------------- #

# Looks this documentation for more information about the specific setup.

# Installation guide.
# https://wiki.archlinux.org/index.php/Installation_guide

# Laptop main page contains links to article.
# https://wiki.archlinux.org/index.php/Laptop

# List of applications.
# https://wiki.archlinux.org/index.php/List_of_applications

# Codecs.
# https://wiki.archlinux.org/index.php/Codecs

# Openbox: window manager.
# http://openbox.org/wiki/Help:Getting_started

# ------------- #
# Set up Pacman #
# ------------- #

# Upgrade Arch Linux.
sudo pacman --sync --refresh --refresh --sysupgrade --noconfirm

# Create a back up
sudo cp --force --preserve=mode,ownership,timestamps /etc/resolv.conf /etc/resolv.conf.backup

# Set up the local DNS.
echo '
# Google DNS
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 2001:4860:4860::8888
nameserver 2001:4860:4860::8844
' | sudo tee --append /etc/resolv.conf

# Install Yay. This package installs the AUR packages.
funcInstallYay

# Restore the DNS
sudo mv /etc/resolv.conf /etc/resolv.conf.google
sudo cp --force --preserve=mode,ownership,timestamps /etc/resolv.conf.backup /etc/resolv.conf

# ------------------- #
# Set up the generals #
# ------------------- #

# Create a directories for the next scripts.
mkdir --parents ~/.config
mkdir --parents ~/workspace

# Change user for the xinitrc file.
sed --in-place -- 's/wolf/'"${userId}"'/g' ~/.xinitrc

# Install the command-line tool that finds all the optional packages of the packages that were pointed by you. It can install the packages.
yay --sync --needed --noconfirm optional-packages

# Install the command-line tool that changes the brightness using the xrandr command.
yay --sync --needed --noconfirm brightness-xrandr

# Install fonts.
optional-packages --install yes fontconfig
optional-packages --install yes awesome-terminal-fonts
optional-packages --install yes gnu-free-fonts
optional-packages --install yes noto-fonts
optional-packages --install yes ttf-bitstream-vera
optional-packages --install yes ttf-croscore
optional-packages --install yes ttf-dejavu
optional-packages --install yes ttf-freefont
optional-packages --install yes ttf-droid
optional-packages --install yes ttf-ibm-plex
optional-packages --install yes ttf-liberation
optional-packages --install yes ttf-hack
optional-packages --install yes ttf-nerd-fonts-symbols
optional-packages --install yes ttf-nerd-fonts-symbols-common
optional-packages --install yes ttf-nerd-fonts-symbols-mono

# Install GNU Bourne Again shell.
optional-packages --install yes bash

# Install the GNU Debugger.
optional-packages --install yes gdb

# Install the next generation, high-performance debugger.
optional-packages --install yes lldb

# Install Linux headers
optional-packages --install yes linux-headers

# Install a highly capable, feature-rich programming language.
optional-packages --install yes perl

# Install the systems programming language focused on safety, speed, and concurrency.
optional-packages --install yes rust

# Install a C library that implements an SQL database engine.
optional-packages --install yes sqlite

# Install the next generation of the python high-level scripting language.
optional-packages --install yes python

# Install the screen fetch for ASCII logo in Linux.
optional-packages --install yes screenfetch

# Install the Vi Improved, a highly configurable, improved version of the vi text editor.
optional-packages --install yes vim

# Install the fast distributed version control system.
optional-packages --install yes git

# Install the record and share terminal sessions.
optional-packages --install yes asciinema

# Install the cat clone with syntax highlighting and git integration.
optional-packages --install yes bat

# Install a modern ls with a lot of pretty colors and awesome icons.
optional-packages --install yes lsd

# Install the abstraction for enumerating power devices, listening to device events and querying history and statistics.
optional-packages --install yes upower

# Install the package to list open files for running Unix processes.
optional-packages --install yes lsof

# Install the US English hunspell dictionaries.
optional-packages --install yes hunspell-en_us

# Install the Spanish (Mexico) hunspell dictionary.
optional-packages --install yes hunspell-es_mx

# Install a daemon for delivering ACPI power management events with netlink support.
optional-packages --install yes acpid
# Enable ACPID service.
sudo systemctl enable --now acpid

# Install the terminal multiplexer.
optional-packages --install yes tmux

# Install the alternative to locate, faster and compatible with mlocate's database.
optional-packages --install yes plocate

# Install an arbitrary precision calculator language.
optional-packages --install yes bc

# Install a Perl script wrapper for 'diff' that produces the same output but with pretty 'syntax' highlighting.
optional-packages --install yes colordiff

# Install a shell utility for manipulating Linux IDE drive/driver parameters.
optional-packages --install yes hdparm

# Install a directory listing program displaying a depth indented list of files.
optional-packages --install yes tree

# Install a diagnostic, debugging, and instructional userspace tracer.
optional-packages --install yes strace

# Install the utility for network discovery and security auditing.
optional-packages --install yes nmap

# Install a console-based network traffic monitor.
optional-packages --install yes vnstat

# Install a command line interface for testing internet bandwidth using speedtest.net.
optional-packages --install yes speedtest-cli

# Install a tool to measure maximum TCP bandwidth.
optional-packages --install yes iperf

# # Install the daemons for the bluetooth protocol stack.
optional-packages --install yes bluez

# Install the development and debugging utilities for the bluetooth protocol stack.
optional-packages --install yes bluez-utils

# Install the Generate a sound when the battery is discharging.
yay --sync --needed --noconfirm battery-discharging

# Audio Alsa.
# https://wiki.gentoo.org/wiki/ALSA
# Install Alsa utils.
optional-packages --install yes alsa-utils
# Adding audio into the user group.
sudo usermod -a -G audio "$(whoami)"

# Install Pulse audio.
# Install a featureful, general-purpose sound server
optional-packages --install yes pulseaudio

# Install speech synthesis.
optional-packages --install yes speech-dispatcher

# ------------------------ #
# Set up the laptop woofer #
# ------------------------ #

# Configure pulseaudio to recognize the woofer.
# Configuring the daemon.conf file.
#cp /etc/pulse/daemon.conf ~/.config/pulse/
#sed --in-place '/; enable-lfe-remixing = no/ s/^;;* *//' ~/.config/pulse/daemon.conf
#sed --in-place 's/enable-lfe-remixing = no/enable-lfe-remixing = yes/g' ~/.config/pulse/daemon.conf
#ehco -e "Configuring the default.pa file"
#cp /etc/pulse/default.pa ~/.config/pulse/
#sed --in-place "\$a\\\n\nload-module module-combine channels=6 channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe" ~/.config/pulse/default.pa
#echo -e "\n"
# Try to test the woofer.
#speaker-test -c6 -s6 -twav
# http://www.leeenux-linux.com/blog/woofer-and-subwoofer-test/
# http://www.leeenux-linux.com/WooferTest/120-129.mp3

# Useful commands.
#speaker-test -c2 -twav -l1
#speaker-test -c6 -twav -l1
#aplay --list-devices
#aplay -L
#amixer controls | grep Master
#cat /sys/class/sound/card*/id
#cat /proc/asound/card0/pcm0p/info
#cat /proc/asound/card0/pcm3p/info

# ------------------------------- #
# Install Black Arch repositories #
# ------------------------------- #

# Install Black Arch repository
#curl --location https://blackarch.org/strap.sh > ~/blackarch-repo.sh
#chmod a+x ~/blackarch-repo.sh
#sudo ~/blackarch-repo.sh
#rm --force ~/blackarch-repo.sh
#sudo pacman --sync --refresh --refresh --sysupgrade --noconfirm

# ----------------- #
# Set up Mkinitcpio #
# ----------------- #

# Mkinitcpio: Possibly missing firmware for module XXXX.
# ------------------------------------------------------
# Install the adaptec SAS 44300, 48300, 58300 Sequencer Firmware for AIC94xx driver.
yay --sync --needed --noconfirm aic94xx-firmware
# Install the aspeed VGA module from the IPMI.
yay --sync --needed --noconfirm ast-firmware
# Install the driver for Western Digital WD7193, WD7197 and WD7296 SCSI cards.
yay --sync --needed --noconfirm wd719x-firmware
# Install the renesas uPD720201 / uPD720202 USB 3.0 chipsets firmware.
yay --sync --needed --noconfirm upd72020x-fw

# Initramfs, create an initial ramdisk environment.
sudo mkinitcpio --preset linux

# -------- #
# Finished #
# -------- #

# The next step is set up Graphic interface.
# The machine will be rebooted, then enter with the created user.

# In the directory 'cd ~/workspace/projects/'.
# Go inside 'cd archlinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/'.
# Go to the folder 'cd 04-setup/'.
# The next step is run './02-graphics-system.bash'.

read -n 1 -s -r -p "Press any key to reboot."

# Reboot
sudo reboot
