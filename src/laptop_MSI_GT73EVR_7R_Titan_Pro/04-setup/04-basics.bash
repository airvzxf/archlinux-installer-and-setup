#!/bin/bash
source 00-config.bash

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Basics
# ----------------------------------------------------------------------
funcIsConnectedToInternet
mkdir --parents ~/.config

# This is the basics packages I suggest to install

# Update the repositories
echo -e "Updating repositories"
sudo pacman --sync --refresh --refresh --sysupgrade --noconfirmu
echo -e "\n"

# Basic packages (apps)
echo -e "Installing geany"
# Text editor
sudo pacman --sync --needed --noconfirm geany geany-plugins
cp --recursive ./setup-resources/.config/geany ~/.config/
sed --in-place -- 's/wolfMachine/'${computerName}'/g' ~/.config/geany/geany.conf
sed --in-place -- 's/wolf/'${userId}'/g' ~/.config/geany/geany.conf
echo -e "\n"

echo -e "Installing bc terminal calculator"
sudo pacman --sync --needed --noconfirm bc # Terminal calculator
echo -e "\n"

echo -e "Installing galculator"
sudo pacman --sync --needed --noconfirm galculator # Calculator
echo -e "\n"

echo -e "Installing ePDF viewer"
sudo pacman --sync --needed --noconfirm epdfview # PDF Viewer
echo -e "\n"

echo -e "Installing lximage viewer"
sudo pacman --sync --needed --noconfirm lximage-qt # Image viewer
echo -e "\n"

echo -e "Installing vlc"
sudo pacman --sync --needed --noconfirm vlc
echo -e "\n"

echo -e "Installing GStreamer ffmpeg"
sudo pacman --sync --needed --noconfirm gst-libav # GStreamer ffmpeg Plugin
echo -e "\n"

echo -e "Installing screanshooter"
sudo pacman --sync --needed --noconfirm xfce4-screenshooter # Screenshots
echo -e "\n"

echo -e "Installing hdd parameters"
sudo pacman --sync --needed --noconfirm hdparm #List brand and properties for your hard disk
echo -e "\n"

echo -e "Installing color diff"
sudo pacman --sync --needed --noconfirm colordiff #Diff command with pretty output
echo -e "\n"

echo -e "Installing spotify"
#gpg --recv-keys 13B00F1FD2C19886 # This is the public key for Spotify AUR
yay -S --needed --noconfirm spotify # Spotify
echo -e "\n"

# Web browsers
# I recommend install all of these because
# palemoon is based on Firefox focusing on efficiency, low memory and cpu
# Firefox is so cool with the graphics
# Chromium the most standar in Linux
echo -e "Installing TTF free font"
sudo pacman --sync --needed --noconfirm ttf-freefont
# if it not works try: ttf-dejavu
echo -e "\n"

echo -e "Installing firefox"
sudo pacman --sync --needed --noconfirm firefox
echo -e "\n"

echo -e "Installing chromium"
sudo pacman --sync --needed --noconfirm chromium
echo -e "\n"

# Firefox Adons
# Lastpass
# Full Web Page Screenshots (♥♥♥♥♥)
# Screenshoter (Fixed)

# Software engineers
echo -e "Installing git"
sudo pacman --sync --needed --noconfirm git
echo -e "\n"

# More packages
echo -e "Installing transmission"
sudo pacman --sync --needed --noconfirm transmission-gtk # Torrents
cp --recursive ./setup-resources/.config/transmission ~/.config/
sed --in-place -- 's/wolf/'${userId}'/g' ~/.config/transmission/settings.json
echo -e "\n"

#~ echo -e "Installing LibreOffice"
#~ sudo pacman --sync --needed --noconfirm libreoffice-fresh # Office
#~ echo -e "\n"

echo -e "Installing Tree"
sudo pacman --sync --needed --noconfirm tree # A directory listing program displaying a depth indented list of files
echo -e "\n"

echo -e "Installing Obconf Openbox configuration tool"
sudo pacman --sync --needed --noconfirm obconf # Configuration tool for the Openbox windowmanager
echo -e "\n"

echo -e "Installing youtube-dl"
sudo pacman --sync --needed --noconfirm youtube-dl #Download youtube videos
echo -e "\n"

echo -e "Installing 'cmake'. A cross-platform open-source make system"
sudo pacman --sync --needed --noconfirm cmake
echo -e "\n"

echo -e "Installing System tools"
sudo pacman --sync --needed --noconfirm lshw #ls hardware
echo -e "\n"

echo -e "Installing lsof. LiSt Open Files"
sudo pacman --sync --needed --noconfirm lsof #'LiSt Open Files' is used to find out which files are open by which process
echo -e "\n"

echo -e "Installing Network tools"
sudo pacman --sync --needed --noconfirm iw #Configuration utility for wireless devices
sudo pacman --sync --needed --noconfirm strace #Track the connection with other server (internet too)
sudo pacman --sync --needed --noconfirm nmap #Network scanning tool
sudo pacman --sync --needed --noconfirm vnstat #A console-based network traffic monitor
sudo pacman --sync --needed --noconfirm ethtool #Utility to query the network driver and hardware settings
sudo pacman --sync --needed --noconfirm speedtest-cli #Command line interface for testing internet bandwidth using speedtest.net
sudo pacman --sync --needed --noconfirm iperf #Command line interface for testing internet bandwidth using speedtest.net
echo -e "\n"


echo -e "Installing Bluetooth"
sudo pacman --sync --needed --noconfirm bluez bluez-utils
sudo pacman --sync --needed --noconfirm bluez-libs pulseaudio-bluetooth pulseaudio-alsa pavucontrol rfkill
#sudo pacman --sync --needed --noconfirm bluez-firmware

sudo usermod -a -G lp $(whoami)

audio_bluetooth=/etc/bluetooth/audio.conf

echo -e \
'[General]
Enable=Source,Sink,Media,Socket' | sudo tee ${audio_bluetooth}

modprobe btusb
#sudo systemctl start bluetooth.service
echo -e "\n"


echo -e "Ready! The next step is run './05a-boinc.bash'.\n"
echo -e "Finished successfully!"
echo -e ""
