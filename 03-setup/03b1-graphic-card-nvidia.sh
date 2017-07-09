#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Nvidia graphic card
# ----------------------------------------------------------------------
# When upgrade pacman some time we lost the nvidia drivers we need to
# re-install that.

# Check what graphic cards have in your computer
lspci -k | grep -A 2 -E "(VGA|3D)"

# Install basic packages
sudo pacman -S --noconfirm linux-headers
sudo pacman -S --noconfirm xorg-xrandr
sudo pacman -S --noconfirm xorg-xdpyinfo
sudo pacman -S --noconfirm xorg-fonts-type1
sudo pacman -S --noconfirm bbswitch

# Install nvidia packages
yaourt -S --noconfirm nvidia-utils-beta
yaourt -S --noconfirm nvidia-beta
yaourt -S --noconfirm nvidia-xrun

# Install the windows manager
sudo pacman --noconfirm -S openbox
sudo pacman --noconfirm -S acpid

# If you try to run the command xinit your screen freezen to solve this
# problem you need to install nvidia-xrun which avoid this problem and
# you need to create a file to setup enviorement in this example we have
# three lines:
# 1. xrandr setup your display appropriated
# 2. setxkbmap setup your keyword map and layout because xrun avoid all
# the xorg configs, every Xorg setup you need to put in this file.
# 3. openbox open the window manager (desktop)
echo -e "xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112" > ~/.nvidia-xinitrc
echo -e "setxkbmap -model pc105 -layout latam -variant ,deadtilde" >> ~/.nvidia-xinitrc
echo -e "openbox-session" >> ~/.nvidia-xinitrc

# Close all the startX with `killall -15 Xorg`, then you shouldn't use
# startx any more you need nvidia-xrun
#killall -15 Xorg
nvidia-xrun

# NOTE: It's important to execute the script 03b2-graphic-card-nvidia-after-install.sh
# when you run your nvidia-xrun and open a kconsole terminal.



# Avoid errors in the log
# ----------------------------------------------------------------------

# (WW) NVIDIA(0): Unable to get display device for DPI computation
# NVIDIA(0): DPI set to (75, 75); computed from built-in default
#sudo nvidia-xconfig

# If you are on laptop, it might be a good idea to install and enable the acpid daemon instead.
# https://wiki.archlinux.org/index.php/NVIDIA/Tips_and_tricks#Manual_configuration
# https://wiki.archlinux.org/index.php/Acpid
#sudo pacman -S acpid
#systemctl start acpid.service

# (WW) The directory "/usr/share/fonts/Type1/" does not exist.
#sudo pacman -S xorg-fonts-type1

# Change the font type
# https://wiki.archlinux.org/index.php/Font_configuration
# http://news.softpedia.com/news/How-to-Add-Beautiful-Fonts-to-Any-Linux-Distribution-434835.shtml

# (WW) Open ACPI failed (/var/run/acpid.socket) (No such file or directory)
# https://bbs.archlinux.org/viewtopic.php?id=64039



# Detailed explanation about the Nvidia installation
# ----------------------------------------------------------------------
# https://wiki.archlinux.org/index.php/NVIDIA#Installation

# Check what graphic card do you have
#lspci -k | grep -A 2 -E "(VGA|3D)"
# 01:00.0 3D controller: NVIDIA Corporation GK107M [GeForce GT 740M] (rev a1)


# 1. Check if your card is new or old
# ---------------------------------------------------
# https://nouveau.freedesktop.org/wiki/CodeNames/

# Code name: NVE0
# Official Name: GeForce 600, GeForce 700, GeForce GTX Titan
# Nvidia 3D object codename: Kepler
# Some 6xx & 7xx series cards are from the NVC0 family instead.

# NVE0 family (Kepler)
# First family to support using 4 monitors simultaneously on one GPU, older generations had only 2 CRTCs.
# NVE7 (GK107)
# GeForce GT (640[M], 645M, 650M, 710M, 720M, 730M, 740[M], ...

# http://www.nvidia.com/Download/index.aspx
# ---------------------------------------------------

# http://www.nvidia.com/download/driverResults.aspx/114708/en-us
# Linux x64 (AMD64/EM64T) Display Driver
# Version:  375.39
# Release Date:     2017.2.14
# Operating System:     Linux 64-bit
# Language:     English (US)
# File Size:    73.68 MB

# More information
# ---------------------------------------------------
# https://en.wikipedia.org/wiki/GeForce_700_series

# Code name: GK107
# Launch: April 1, 2013
# Fab: 28
# BUS: PCIe 3.0 x16
# Core config: 384:32:16


# 2. Check your appropriate driver
# ---------------------------------------------------

# Install the appropriate driver for your card:
# - For GeForce 400 series cards and newer [NVCx and newer], install the nvidia or nvidia-lts package. If these packages do not work, nvidia-betaAUR may have a newer driver version that offers support.
# https://www.archlinux.org/packages/extra/x86_64/nvidia/
# https://www.archlinux.org/packages/extra/x86_64/nvidia-lts/
# https://aur.archlinux.org/packages/nvidia-beta/

# NOTE: In my personal opinion I should install the nvidia-beta because we have more options, checks "Required by (15)" section, for example:
# - ffmpeg-nvenc. Complete solution to record, convert and stream audio and video with Nvidia CUDA Hardware Acceleration
# - cpyrit-cuda: Pyrit support for Nvidia-CUDA.
# - hoomd-blue: A general-purpose particle simulation toolkit using GPUs with CUDA.

# 3. Set up nvidia-xinitrc
# ---------------------------------------------------
# Before set this values you need to get the number of dpis for your
# display. There some explanation in the next step.
# Add this lines:
#xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112
#setxkbmap -model pc105 -layout latam -variant ,deadtilde
#openbox-session
# OR Execute this line
#echo -e "xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112\nsetxkbmap -model pc105 -layout latam -variant ,deadtilde\nopenbox-session\n" | sudo tee ~/.nvidia-xinitrc > /dev/null

# WARNING: libpng warning: iCCP: known incorrect sRGB profile
# https://wiki.archlinux.org/index.php/Libpng_errors
# convert -strip input_filename output_filename


# 4. Get DPIs
# ---------------------------------------------------
#xrandr | grep -w connected
# LVDS-1-1 connected 1366x768+0+0 (normal left inverted right x axis y axis) 309mm x 173mm

# Use the information, get the size in millimeters and convert to cm,
# 309 mm x 173 mm
# 30.9 cm x 17.3 cm

# Get Inches: divide CM between 2.54, always use 2.54
# x = 30.9/2.54 = 12.17 in
# y = 17.3/2.54 = 6.81 in

# Divide the resolution (1366x768) between in (12.17x6.81)
# x = 1366/12.17 = 112.24 dpis
# y = 768/6.81 = 112.78 dpis

# Get information about the screen
#xrandr

# Create your xrandr configurations, right now you have all the information.
#xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112

# Check the output. IMPORTANT: At this point you wouldn't see any changes.
#xdpyinfo | grep -B2 resolution
# screen #0:
#  dimensions:    1366x768 pixels (309x174 millimeters)
#  resolution:    112x112 dots per inch
