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

# ---------------------- #
# Set up network resolve #
# ---------------------- #

# Create a backup
sudo cp --force --preserve=mode,ownership,timestamps /etc/resolv.conf /etc/resolv-"$(date +%Y-%m-%d-%H-%M-%S-%N)".conf

# Set up the local DNS.
echo "
# DNS from your ISP (Internet company).
# Go to the Web interface from your ISP modem and get the DNS information.
${nameserverIPv4One}
${nameserverIPv4Two}
${nameserverIPv6One}
${nameserverIPv6Two}

# Google DNS
#nameserver 8.8.8.8
#nameserver 8.8.4.4
#nameserver 2001:4860:4860::8888
#nameserver 2001:4860:4860::8844
" | sudo tee /etc/resolv.conf

# Flush all local DNS caches.
sudo resolvectl flush-caches

# ------------- #
# Set up Pacman #
# ------------- #

# Enable the system timer to start Reflector.
sudo systemctl enable reflector.timer

# Start the system timer of the Reflector.
sudo systemctl restart reflector.timer

# Enable the automatic system service that updates the mirror list with Reflector.
sudo systemctl enable reflector

# Restart the Reflector service.
sudo systemctl restart reflector

# Upgrade Arch Linux.
sudo pacman --sync --refresh --refresh --sysupgrade --noconfirm

# Install Yay. This package installs the AUR packages.
funcInstallYay

# ------------------- #
# Set up the generals #
# ------------------- #

# Create a directories for the next scripts.
mkdir --parents ~/.config
mkdir --parents ~/workspace

# Change user for the xinitrc file.
sed --in-place -- 's/wolf/'"${userId}"'/g' ~/.xinitrc

# Install the fonts.
# Install the GNU Bourne Again shell.
# Install the programmable completion for the bash shell.
# Install the GNU Debugger.
# Install the next generation, high-performance debugger.
# Install Linux headers
# Install a highly capable, feature-rich programming language.
# Install the systems programming language focused on safety, speed, and concurrency.
# Install a C library that implements an SQL database engine.
# Install a windowing toolkit for use with tcl.
# Install the next generation of the python high-level scripting language.
# Install the PyPA recommended tool for installing Python packages.
# Install the virtual Python Environment builder.
# Install the screen fetch for ASCII logo in Linux.
# Install the Vi Improved, a highly configurable, improved version of the vi text editor.
# Install the fast distributed version control system.
# Install the SSH protocol implementation for remote login, command execution, and file transfer.
# Install the library for storing and retrieving passwords and other secrets.
# Install the record and share terminal sessions.
# Install the cat clone with syntax highlighting and git integration.
# Install a modern ls with a lot of pretty colors and awesome icons.
# Install the abstraction for enumerating power devices, listening to device events and querying history and statistics.
# Install the package to list open files for running Unix processes.
# Install the spell checker and morphological analyzer library and program.
# Install the US English hunspell dictionaries.
# Install the Spanish (Mexico) hunspell dictionary.
# Install a daemon for delivering ACPI power management events with netlink support.
# Install the terminal multiplexer.
# Install the alternative to locate, faster and compatible with mlocate's database.
# Install an arbitrary precision calculator language.
# Install the utility programs used for creating patch files.
# Install a Perl script wrapper for 'diff' that produces the same output but with pretty 'syntax' highlighting.
# Install a shell utility for manipulating Linux IDE drive/driver parameters.
# Install a directory listing program displaying a depth indented list of files.
# Install a diagnostic, debugging, and instructional userspace tracer.
# Install the utility for network discovery and security auditing.
# Install a command line interface for testing internet bandwidth using speedtest.net.
# Install a tool to measure maximum TCP bandwidth.
# Install the daemons for the bluetooth protocol stack.
# Install the development and debugging utilities for the bluetooth protocol stack.
# Install the compressor/archiver for creating and modifying zipfiles.
# Install the package for extracting and viewing files in .zip archives.
# Install the GPUs process monitoring for AMD, Intel and NVIDIA.
# Install the Android platform tools.
# Install Alsa utils.
# Install a feature, general-purpose sound server.
# Install the ALSA Configuration for PulseAudio.
# Install the Bluetooth support for PulseAudio.
# Install the graphical equalizer for PulseAudio.
# Install the jack support for PulseAudio.
# Install the CLI and curses mixer for pulseaudio.
# Install the high-level device independent layer for speech synthesis interface.
# Install the multilingual software speech synthesizer.
# Install a general multilingual speech synthesis system.
# Install the American male/female and scottish English male speaker.
# Install the miscellaneous system utilities for Linux.
# Install the portable bandwidth monitor and rate estimator.
sudo pacman --sync --needed --noconfirm \
  fontconfig awesome-terminal-fonts gnu-free-fonts noto-fonts noto-fonts-extra noto-fonts-emoji \
  noto-fonts-cjk ttf-bitstream-vera ttf-croscore ttf-dejavu ttf-freefont ttf-droid ttf-ibm-plex \
  ttf-liberation ttf-hack ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols \
  ttf-nerd-fonts-symbols-mono \
  bash bash-completion gdb lldb linux-headers perl rustup sqlite tk python python-pip \
  python-virtualenv screenfetch vim git openssh libsecret asciinema bat lsd upower lsof hunspell \
  hunspell-en_us hunspell-es_mx acpid tmux plocate bc diffutils colordiff hdparm tree strace \
  nmap speedtest-cli iperf bluez bluez-utils zip unzip nvtop android-tools alsa-utils pulseaudio \
  pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pulseaudio-jack pulsemixer \
  speech-dispatcher espeak-ng festival festival-us util-linux bmon

# Install the command-line tool that changes the brightness using the xrandr command.
# Install the tool to generate a sound when the battery is discharging.
# --------------------------------------------------
# Mkinitcpio: Possibly missing firmware for modules.
# --------------------------------------------------
# Install the aic94xx-firmware adaptec SAS 44300, 48300, 58300 Sequencer Firmware for AIC94xx driver.
# Install the ast-firmware aspeed VGA module from the IPMI.
# Install the wd719x-firmware driver for Western Digital WD7193, WD7197 and WD7296 SCSI cards.
# Install the upd72020x-fw renesas uPD720201 / uPD720202 USB 3.0-chipset firmware.
# NOTE: This step is not necessary because the above firmwares executed the mkinitcpio for Linux.
yay --sync --needed --noconfirm \
  brightness-xrandr battery-discharging aic94xx-firmware ast-firmware wd719x-firmware upd72020x-fw

# Enable ACPID service.
sudo systemctl enable --now acpid

# Audio Alsa.
# https://wiki.gentoo.org/wiki/ALSA
# Adding audio into the user group.
sudo usermod -a -G audio "$(whoami)"

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
#amixer controls | grep -i master
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
