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
sudo pacman -S --noconfirm geany # Text editor
sudo pacman -S --noconfirm epdfview # PDF Viewer
sudo pacman -S --noconfirm reflector # Sorted mirrors in Arch Linux
sudo pacman -S --noconfirm parole # Media player
sudo pacman -S --noconfirm hdparm #List brand and properties for your hard disk
sudo hdparm -I /dev/sda
sudo pacman -S --noconfirm xfce4-screenshooter # Screenshots
yaourt -S spotify-stable # Spotify


# Web browsers
# I recommend install all of these because
# palemoon is based on Firefox focusing on efficiency, low memory and cpu
# Firefox is so cool with the graphics
# Chromium the most standar in Linux
sudo pacman -S --noconfirm firefox
sudo pacman -S --noconfirm chromium
yaourt -S --noconfirm palemoon-bin

# Firefox Adons
# Lastpass
# Full Web Page Screenshots (♥♥♥♥♥)
# Screenshoter (Fixed)

# Software engineers
sudo pacman -S --noconfirm git

# More
sudo pacman -S --noconfirm transmission-gtk # Torrents
