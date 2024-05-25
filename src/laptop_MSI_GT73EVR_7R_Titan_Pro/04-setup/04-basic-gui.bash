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
sudo pacman --sync --refresh --refresh --sysupgrade --noconfirm

# Install a fast and lightweight IDE.
# Install a GTK+ based scientific calculator.
# Install a lightweight PDF and XPS viewer.
# Install a multi-platform MPEG, VCD/DVD, and DivX player.
# Install an application to take screenshots.
# Install a web browser built for speed, simplicity, and security.
# Install the standalone web browser from mozilla.org.
# Install the fast, easy, and free BitTorrent client (GTK+ GUI).
# Install the LibreOffice branch which contains new features and program enhancements.
# Install Spanish language pack for LibreOffice Fresh.
# Install a GTK+ based configuration tool for the Openbox windowmanager.
# Install the image viewer for Wayland and X11.
# Install a cross-platform open-source make system.
# Install a small tool to provide detailed information on the hardware configuration of the machine.
# Install the Bluetooth support for PulseAudio.
# Install the ALSA Configuration for PulseAudio.
# Install the PulseAudio Volume Control.
sudo pacman --sync --needed --noconfirm \
  geany geany-plugins galculator mupdf vlc xfce4-screenshooter chromium firefox \
  firefox-i18n-es-mx transmission-gtk libreoffice-fresh libreoffice-fresh-es \
  obconf imv cmake make lshw pulseaudio-bluetooth pulseaudio-alsa pavucontrol

# TODO: Check if I need this package.
# Install the multimedia graph framework - libav plugin.
#sudo pacman --sync --needed --noconfirm gst-libav

# TODO: Check if I need this package.
# Install the firmwares for Broadcom BCM203x and STLC2300 Bluetooth chips.
#yay --sync --needed --noconfirm bluez-firmware

# TODO: Check if I need this package.
# Install the deprecated libraries for the bluetooth protocol stack.
# sudo pacman --sync --needed --noconfirm bluez-libs

# Change default MIME type opener to Firefox.
MIME_TYPES=$(grep -oP "<mime-type type=\"\K\w+/\w+" /usr/share/mime/packages/freedesktop.org.xml | sort | uniq)

for mime_type in ${MIME_TYPES}; do
  mime_default=$(xdg-mime query default "${mime_type}")

  if [[ "${mime_default}" == "chromium.desktop" ]]; then
    echo "MIME type: ${mime_type}"
    echo "MIME default: ${mime_default}"
    echo "It will change the default to Firefox"
    xdg-mime default firefox.desktop "${mime_type}"
    echo ""
  fi
done

# Update the configuration files for geany.
sed --in-place -- 's/wolfMachine/'${computerName}'/g' ~/.config/geany/geany.conf
sed --in-place -- 's/wolf/'${userId}'/g' ~/.config/geany/geany.conf

# Update the configuration files for transmission.
sed --in-place -- 's/wolf/'${userId}'/g' ~/.config/transmission/settings.json

# Add the user to the LP group.
sudo usermod -a -G lp "$(whoami)"

# Enable Bluetooth headset.
echo "[General]
Enable=Source,Sink,Media,Socket" | sudo tee /etc/bluetooth/audio.conf

# Add and remove the btusb module from the Linux.
sudo modprobe btusb

# Start the Bluetooth service.
sudo systemctl enable --now bluetooth.service

# -------- #
# Finished #
# -------- #

# The next step is set up video games.
# Execute './05-video-games.bash'.
