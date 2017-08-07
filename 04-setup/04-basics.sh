#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Basics
# ----------------------------------------------------------------------
# This is the basics packages I suggest to install
echo -e ""

# Update the repositories
echo -e "Updating repositories"
echo -e ""
sudo pacman -Syu
echo -e "\n"

# Basic packages (apps)
echo -e "Installing konsole"
echo -e ""
sudo pacman -S --needed --noconfirm konsole # Terminal / Console window
echo -e "\n"

echo -e "Installing geany"
echo -e ""
sudo pacman -S --needed --noconfirm geany geany-plugins # Text editor
echo -e "\n"

echo -e "Installing ePDF viewr"
echo -e ""
sudo pacman -S --needed --noconfirm epdfview # PDF Viewer
echo -e "\n"

echo -e "Installing reflector"
echo -e ""
sudo pacman -S --needed --noconfirm reflector # Sorted mirrors in Arch Linux
echo -e "\n"

echo -e "Installing Parole"
echo -e ""
sudo pacman -S --needed --noconfirm parole # Media player
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
sudo hdparm -I /dev/sda
echo -e "\n"

echo -e "Installing spotify"
echo -e ""
yaourt -S --needed --noconfirm spotify-stable # Spotify
echo -e "\n"

echo -e "Installing redshift"
echo -e ""
sudo pacman -S --needed --noconfirm redshift # Automatically adjusts the color temperature of your screen
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
sudo pacman -S --needed firefox
echo -e "\n"

echo -e "Installing chromium"
echo -e ""
sudo pacman -S --needed --noconfirm chromium
echo -e "\n"

#~ echo -e "Installing palemoon"
#~ echo -e ""
#~ yaourt -S --needed --noconfirm palemoon-bin
#~ echo -e "\n"

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
echo -e "\n"


echo -e "Finished successfully!"
echo -e ""
