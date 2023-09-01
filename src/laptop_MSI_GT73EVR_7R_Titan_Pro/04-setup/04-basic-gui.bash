#!/usr/bin/env bash
set -ve

# ----------------------------------------------------------------------
# Arch Linux :: Set up - Basics GUI
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

# ----------------------- #
# BASIC SET UP IN THE GUI #
# ----------------------- #

source ./../00-configuration.bash

funcIsConnectedToInternet

# --------------------- #
# Basic packages (apps) #
# --------------------- #

# Update the repositories
sudo pacman --sync --refresh --refresh --sysupgrade --noconfirmu

# Install a fast and lightweight IDE.
optional-packages --install yes geany
sed --in-place -- 's/wolfMachine/'${computerName}'/g' ~/.config/geany/geany.conf
sed --in-place -- 's/wolf/'${userId}'/g' ~/.config/geany/geany.conf

# Install a GTK+ based scientific calculator.
optional-packages --install yes galculator

# Install a simple PDF reader, supporting bookmarks, highlights, and annotations.
optional-packages --install yes deepin-reader

# Install a lightweight PDF and XPS viewer.
optional-packages --install yes mupdf

# Install a multi-platform MPEG, VCD/DVD, and DivX player.
optional-packages --install yes --exclude pipewire-alsa pipewire-jack pipewire-pulse --packages vlc

# TODO: Is this package needed?
# Install the multimedia graph framework - libav plugin.
#optional-packages --install yes gst-libav

# Install an application to take screenshots.
optional-packages --install yes xfce4-screenshooter

# Install a web browser built for speed, simplicity, and security.
optional-packages --install yes --exclude pipewire-alsa pipewire-jack pipewire-pulse --packages chromium

# Install the standalone web browser from mozilla.org.
optional-packages --install yes firefox

# Install the fast, easy, and free BitTorrent client (GTK+ GUI).
optional-packages --install yes transmission-gtk
sed --in-place -- 's/wolf/'${userId}'/g' ~/.config/transmission/settings.json

# Install the LibreOffice branch which contains new features and program enhancements.
optional-packages --install yes libreoffice-fresh

# Install Spanish language pack for LibreOffice Fresh.
optional-packages --install yes libreoffice-fresh-es

# Install a GTK+ based configuration tool for the Openbox windowmanager.
optional-packages --install yes obconf

# Install a command-line program to download videos from YouTube.com and a few more sites.
optional-packages --install yes youtube-dl

# Install the image viewer for Wayland and X11.
optional-packages --install yes imv

# Install a cross-platform open-source make system.
optional-packages --install yes cmake

# Install a small tool to provide detailed information on the hardware configuration of the machine.
optional-packages --install yes lshw

# TODO: Check if I need this package.
# Install the deprecated libraries for the bluetooth protocol stack.
# optional-packages --install yes bluez-libs

# Install the Bluetooth support for PulseAudio.
optional-packages --install yes pulseaudio-bluetooth

# Install the ALSA Configuration for PulseAudio.
optional-packages --install yes pulseaudio-alsa

# Install the PulseAudio Volume Control.
optional-packages --install yes pavucontrol

# Install the miscellaneous system utilities for Linux.
optional-packages --install yes util-linux

# TODO: Check if I need this package.
# Install the firmwares for Broadcom BCM203x and STLC2300 Bluetooth chips.
#yay --sync --needed --noconfirm bluez-firmware

# Add the user to the LP group.
sudo usermod -a -G lp $(whoami)

# Enable Bluetooth headset.
echo -e \
'[General]
Enable=Source,Sink,Media,Socket' | sudo tee /etc/bluetooth/audio.conf

# Add and remove the btusb module from the Linux.
modprobe btusb

# Start the Bluetooth service.
sudo systemctl start bluetooth.service

# -------- #
# Finished #
# -------- #

# The next step is set up video games.
# Execute './05-video-games.bash'.
