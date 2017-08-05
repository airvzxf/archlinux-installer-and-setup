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

# Update the repositories
sudo pacman -Syu

# Basic packages (apps)
sudo pacman -S --needed konsole # Terminal / Console window
sudo pacman -S --needed geany geany-plugins # Text editor
sudo pacman -S --needed epdfview # PDF Viewer
sudo pacman -S --needed reflector # Sorted mirrors in Arch Linux
sudo pacman -S --needed parole # Media player
sudo pacman -S --needed gst-libav # GStreamer ffmpeg Plugin
sudo pacman -S --needed xfce4-screenshooter # Screenshots
sudo pacman -S --needed hdparm #List brand and properties for your hard disk
sudo hdparm -I /dev/sda
yaourt -S --needed spotify-stable # Spotify


# Web browsers
# I recommend install all of these because
# palemoon is based on Firefox focusing on efficiency, low memory and cpu
# Firefox is so cool with the graphics
# Chromium the most standar in Linux
sudo pacman -S --needed firefox
sudo pacman -S --needed chromium
yaourt -S --needed palemoon-bin

# Firefox Adons
# Lastpass
# Full Web Page Screenshots (♥♥♥♥♥)
# Screenshoter (Fixed)

# Software engineers
sudo pacman -S --needed git

# More packages
sudo pacman -S --needed transmission-gtk # Torrents
