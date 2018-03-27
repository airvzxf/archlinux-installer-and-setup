#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Basics
# ----------------------------------------------------------------------
funcIsConnectedToInternet
mkdir -p ~/.config

# This is the basics packages I suggest to install
echo -e ""

# Update the repositories
echo -e "Updating repositories"
echo -e ""
sudo pacman --noconfirm -Syyu
echo -e "\n"

# Basic packages (apps)
echo -e "Installing geany"
echo -e ""
sudo pacman -S --needed --noconfirm geany geany-plugins # Text editor
cp -R ./setup-resources/.config/geany ~/.config/
sed -i -- 's/wolfMachine/'${yourComputerName}'/g' ~/.config/geany/geany.conf
sed -i -- 's/wolf/'${yourUserName}'/g' ~/.config/geany/geany.conf
echo -e "\n"

echo -e "Installing bc terminal calculator"
echo -e ""
sudo pacman -S --needed --noconfirm bc # Terminal calculator
echo -e "\n"

echo -e "Installing ePDF viewer"
echo -e ""
sudo pacman -S --needed --noconfirm epdfview # PDF Viewer
echo -e "\n"

echo -e "Installing lximage viewer"
echo -e ""
sudo pacman -S --needed --noconfirm lximage-qt # Image viewer
echo -e "\n"

echo -e "Installing reflector"
echo -e ""
sudo pacman -S --needed --noconfirm reflector # Sorted mirrors in Arch Linux
echo -e "\n"

echo -e "Installing vlc"
echo -e ""
sudo pacman -S --needed --noconfirm vlc
echo -e "\n"

echo -e "Installing GStreamer ffmpeg"
echo -e ""
sudo pacman -S --needed --noconfirm gst-libav # GStreamer ffmpeg Plugin
echo -e "\n"

echo -e "Installing screanshooter"
echo -e ""
sudo pacman -S --needed --noconfirm xfce4-screenshooter # Screenshots
echo -e "\n"

echo -e "Installing hdd parameters"
echo -e ""
sudo pacman -S --needed --noconfirm hdparm #List brand and properties for your hard disk
echo -e "\n"

echo -e "Installing color diff"
echo -e ""
sudo pacman -S --needed --noconfirm colordiff #Diff command with pretty output
echo -e "\n"

echo -e "Installing spotify"
echo -e ""
#gpg --recv-keys 13B00F1FD2C19886 # This is the public key for Spotify AUR
#yaourt -S --needed --noconfirm spotify-stable # Spotify
echo -e "\n"

# Web browsers
# I recommend install all of these because
# palemoon is based on Firefox focusing on efficiency, low memory and cpu
# Firefox is so cool with the graphics
# Chromium the most standar in Linux
echo -e "Installing TTF free font"
echo -e ""
sudo pacman -S --needed --noconfirm ttf-freefont
echo -e "\n"

echo -e "Installing firefox"
echo -e ""
sudo pacman -S --needed --noconfirm firefox
echo -e "\n"

echo -e "Installing chromium"
echo -e ""
sudo pacman -S --needed --noconfirm chromium
echo -e "\n"

# Firefox Adons
# Lastpass
# Full Web Page Screenshots (♥♥♥♥♥)
# Screenshoter (Fixed)

# Software engineers
echo -e "Installing git"
echo -e ""
sudo pacman -S --needed --noconfirm git
echo -e "\n"

# More packages
echo -e "Installing transmission"
echo -e ""
sudo pacman -S --needed --noconfirm transmission-gtk # Torrents
cp -R ./setup-resources/.config/transmission ~/.config/
sed -i -- 's/wolf/'${yourUserName}'/g' ~/.config/transmission/settings.json
echo -e "\n"

echo -e "Installing LibreOffice"
echo -e ""
sudo pacman -S --needed --noconfirm libreoffice-fresh # Office
echo -e "\n"

echo -e "Installing Tree"
echo -e ""
sudo pacman -S --needed --noconfirm tree # A directory listing program displaying a depth indented list of files
echo -e "\n"

echo -e "Installing Obconf Openbox configuration tool"
echo -e ""
sudo pacman -S --needed --noconfirm obconf # Configuration tool for the Openbox windowmanager
echo -e "\n"

echo -e "Installing youtube-dl"
echo -e ""
sudo pacman -S --needed --noconfirm youtube-dl #Download youtube videos
echo -e "\n"

echo -e ""
echo -e "Installing 'cmake'. A cross-platform open-source make system"
echo -e ""
sudo pacman -S --needed --noconfirm cmake
echo -e "\n"

echo -e ""
echo -e "Installing Network tools"
echo -e ""
sudo pacman -S --needed --noconfirm iw #Configuration utility for wireless devices
sudo pacman -S --needed --noconfirm strace #Track the connection with other server (internet too)
sudo pacman -S --needed --noconfirm nmap #Network scanning tool
sudo pacman -S --needed --noconfirm vnstat #A console-based network traffic monitor
sudo pacman -S --needed --noconfirm ethtool #Utility to query the network driver and hardware settings
sudo pacman -S --needed --noconfirm speedtest-cli #Command line interface for testing internet bandwidth using speedtest.net
sudo pacman -S --needed --noconfirm iperf #Command line interface for testing internet bandwidth using speedtest.net
echo -e "\n"


echo -e "Installing Bluetooth"
echo -e ""
sudo pacman -S --needed --noconfirm bluez bluez-utils
sudo pacman -S --needed --noconfirm bluez-libs pulseaudio-bluetooth pulseaudio-alsa pavucontrol rfkill
#sudo pacman -S --needed --noconfirm bluez-firmware
sudo usermod -a -G lp $(whoami)
audioBluetooth=/etc/bluetooth/audio.conf
sudo rm -f $audioBluetooth
sudo touch $audioBluetooth
echo -e "[General]" | sudo tee -a $audioBluetooth
echo -e "Enable=Source,Sink,Media,Socket" | sudo tee -a $audioBluetooth
modprobe btusb
#systemctl start bluetooth.service
echo -e "\n"


echo -e "Ready! The next step is run './05a-boinc.sh'.\n"
echo -e "Finished successfully!"
echo -e ""
