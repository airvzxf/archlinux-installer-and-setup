#!/usr/bin/env bash
set -ve

# ----------------------------------------------------------------------
# Arch Linux :: Set up - Basic
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

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
sudo pacman --noconfirm -Syyu

# Install Yay. It installs the AUR packages.
funcInstallYay

# ------------------- #
# Set up the generals #
# ------------------- #

# Create a directories for the next scripts.
mkdir -p ~/.config
mkdir -p ~/workspace

# Change user for the xinitrc file.
sed -i -- 's/wolf/'"${userId}"'/g' ~/.xinitrc

# Intall fonts.
funcInstallPacmanPackageAndDependencies fontconfig
funcInstallPacmanPackageAndDependencies awesome-terminal-fonts
funcInstallPacmanPackageAndDependencies gnu-free-fonts
funcInstallPacmanPackageAndDependencies noto-fonts
funcInstallPacmanPackageAndDependencies ttf-bitstream-vera
funcInstallPacmanPackageAndDependencies ttf-croscore
funcInstallPacmanPackageAndDependencies ttf-dejavu
funcInstallPacmanPackageAndDependencies ttf-droid
funcInstallPacmanPackageAndDependencies ttf-ibm-plex
funcInstallPacmanPackageAndDependencies ttf-liberation
funcInstallPacmanPackageAndDependencies ttf-hack
funcInstallPacmanPackageAndDependencies ttf-nerd-fonts-symbols
funcInstallPacmanPackageAndDependencies ttf-nerd-fonts-symbols-common
funcInstallPacmanPackageAndDependencies ttf-nerd-fonts-symbols-mono

# Install GNU Bourne Again shell.
funcInstallPacmanPackageAndDependencies bash

# Install the programmable completion for the bash shell.
funcInstallPacmanPackageAndDependencies bash-completion

# Install the GNU Debugger.
funcInstallPacmanPackageAndDependencies gdb

# Install the next generation, high-performance debugger.
funcInstallPacmanPackageAndDependencies lldb

# Install Linux headers
funcInstallPacmanPackageAndDependencies linux-headers

# Intall a highly capable, feature-rich programming language .
funcInstallPacmanPackageAndDependencies perl

# Install the systems programming language focused on safety, speed and concurrency.
funcInstallPacmanPackageAndDependencies rust

# Install a C library that implements an SQL database engine.
funcInstallPacmanPackageAndDependencies sqlite

# Install the next generation of the python high-level scripting language.
funcInstallPacmanPackageAndDependencies python

# Install the screen fetch for ASCII logo in Linux.
funcInstallPacmanPackageAndDependencies screenfetch

# Install the Vi Improved, a highly configurable, improved version of the vi text editor.
funcInstallPacmanPackageAndDependencies vim

# Install the fast distributed version control system.
funcInstallPacmanPackageAndDependencies git

# Install the record and share terminal sessions.
funcInstallPacmanPackageAndDependencies asciinema

# Install the Cat clone with syntax highlighting and git integration.
funcInstallPacmanPackageAndDependencies bat

# Install the alternative to locate, faster and compatible with mlocate's database.
funcInstallPacmanPackageAndDependencies lsd

# Install the abstraction for enumerating power devices, listening to device events and querying history and statistics.
funcInstallPacmanPackageAndDependencies upower

# Install the US English hunspell dictionaries.
funcInstallPacmanPackageAndDependencies hunspell-en_us

# Install the Spanish (Mexico) hunspell dictionary.
funcInstallPacmanPackageAndDependencies hunspell-es_mx

# Install a daemon for delivering ACPI power management events with netlink support.
funcInstallPacmanPackageAndDependencies acpid
# Enable ACPID service.
sudo systemctl enable --now acpid

# Install the terminal multiplexer.
funcInstallPacmanPackageAndDependencies tmux

# Install the alternative to locate, faster and compatible with mlocate's database.
funcInstallPacmanPackageAndDependencies plocate

# Install the Generate a sound when the battery is discharging..
yay -S --needed --noconfirm battery-discharging-beep-git

# Audio Alsa.
# https://wiki.gentoo.org/wiki/ALSA
# Install Alsa utils.
funcInstallPacmanPackageAndDependencies alsa-utils
# Adding audio into the user group.
sudo usermod -a -G audio "$(whoami)"

# Install Pulse audio.
# Install a featureful, general-purpose sound server
funcInstallPacmanPackageAndDependencies pulseaudio

# Install speech synthesis.
funcInstallPacmanPackageAndDependencies speech-dispatcher

# TODO: Uncomment these lines if the woofer is not working in the next instllation form scratch.
# Configure pulseaudio to recognize the woofer.
# Configuring the daemon.conf file.
#cp /etc/pulse/daemon.conf ~/.config/pulse/
#sed -i '/; enable-lfe-remixing = no/ s/^;;* *//' ~/.config/pulse/daemon.conf
#sed -i 's/enable-lfe-remixing = no/enable-lfe-remixing = yes/g' ~/.config/pulse/daemon.conf
#ehco -e "Configuring the default.pa file"
#cp /etc/pulse/default.pa ~/.config/pulse/
#sed -i "\$a\\\n\nload-module module-combine channels=6 channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe" ~/.config/pulse/default.pa
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

# Install Black Arch repository
# curl -L https://blackarch.org/strap.sh > ~/blackarch-repo.sh
# chmod a+x ~/blackarch-repo.sh
# sudo ~/blackarch-repo.sh
# rm -f ~/blackarch-repo.sh
# sudo pacman -Syy

# ----------------- #
# Set up Mkinitcpio #
# ----------------- #

# TODO: Install all the package to avoid warning during the init.
# Mkinitcpio: Possibly missing firmware for module XXXX.
# ------------------------------------------------------
# Install the adaptec SAS 44300, 48300, 58300 Sequencer Firmware for AIC94xx driver.
yay -S --needed --noconfirm aic94xx-firmware
# Install the aspeed VGA module from the IPMI.
yay -S --needed --noconfirm ast-firmware
# Install the driver for Western Digital WD7193, WD7197 and WD7296 SCSI cards.
yay -S --needed --noconfirm wd719x-firmware
# Install the renesas uPD720201 / uPD720202 USB 3.0 chipsets firmware.
yay -S --needed --noconfirm upd72020x-fw

# Initramfs, create an initial ramdisk environment.
sudo mkinitcpio -p linux

# -------- #
# Finished #
# -------- #

# The next step is set up Graphic interface.
# The machine will be reboot, then enter with the created user.

# In the directory 'cd ~/workspace/projects/'.
# Go inside 'cd archLinux-installer-and-setup/src/laptop_MSI_GT73EVR_7R_Titan_Pro/'.
# Go to the folder 'cd 04-setup/'.
# The next step is run './02-graphics-system.bash'.

read -n 1 -s -r -p "Press any key to reboot"

# Reboot
sudo reboot

