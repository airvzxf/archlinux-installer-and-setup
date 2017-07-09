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
sudo pacman -S --needed --noconfirm geany # Text editor
sudo pacman -S --needed --noconfirm epdfview # PDF Viewer
sudo pacman -S --needed --noconfirm reflector # Sorted mirrors in Arch Linux
sudo pacman -S --needed --noconfirm parole # Media player
sudo pacman -S --needed --noconfirm hdparm #List brand and properties for your hard disk
sudo hdparm -I /dev/sda
sudo pacman -S --needed --noconfirm xfce4-screenshooter # Screenshots
yaourt -S --needed --noconfirm spotify-stable # Spotify


# Web browsers
# I recommend install all of these because
# palemoon is based on Firefox focusing on efficiency, low memory and cpu
# Firefox is so cool with the graphics
# Chromium the most standar in Linux
sudo pacman -S --needed --noconfirm firefox
sudo pacman -S --needed --noconfirm chromium
yaourt -S --needed --noconfirm palemoon-bin

# Firefox Adons
# Lastpass
# Full Web Page Screenshots (♥♥♥♥♥)
# Screenshoter (Fixed)

# Software engineers
sudo pacman -S --needed --noconfirm git

# More
sudo pacman -S --needed --noconfirm transmission-gtk # Torrents
