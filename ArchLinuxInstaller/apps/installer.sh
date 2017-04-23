#!/bin/bash

# Laptop main page contains links to article.
# https://wiki.archlinux.org/index.php/Laptop

# List of applications
# https://wiki.archlinux.org/index.php/List_of_applications

# Codecs
# https://wiki.archlinux.org/index.php/Codecs


# Keyboard configuration in Xorg
# https://wiki.archlinux.org/index.php/Keyboard_configuration_in_Xorg
# Dislpay information
setxkbmap -print -verbose 10
localectl list-x11-keymap-layouts | grep lat
localectl list-x11-keymap-variants latam

# Setup the configuration
localectl --no-convert set-x11-keymap latam pc105 ,deadtilde


pacman -Syuw                           # download packages
rm /etc/ssl/certs/ca-certificates.crt  # remove conflicting file
pacman -Su                             # perform upgradepacman -Rdd ca-certificates-utils
pacman -Rdd ca-certificates-utils
pacman -S ca-certificates-utils
pacman -Syu


# Multilib
# Run and build 32-bit applications on 64-bit installations of Arch Linux. 
# https://wiki.archlinux.org/index.php/Multilib
sudo nano /etc/pacman.conf
# Uncomment the line below of [multilib]
# Include = /etc/pacman.d/mirrorlist
sudo pacman -Syu


# Problems with AUR keys when add or delete packages
# Example: vlc-2.2.4.tar.xz ... FAILED (unknown public key 7180713BE58D1ADC)
# Solve:
# gpg --recv-keys 7180713BE58D1ADC

# Commands
# Show the installed packages and their versions
sudo pacman -Q



# Pacman always with color:
sudo nano /etc/pacman.conf
# Uncomment below: # Misc options
# Color


# Common applications for the OS
sudo pacman -Syu
sudo pacman -S --noconfirm base-devel sudo
sudo pacman -S --noconfirm xdotool
sudo pacman -S --noconfirm xbindkeys
sudo pacman -S --noconfirm reflector
sudo pacman -S --noconfirm git





# Productive applications
sudo pacman -S --noconfirm epdfview # PDF Viewer

# Development applications
sudo pacman -S --noconfirm atom

# Pale Moon web browser
cp palemoon/pminstaller.sh ~/
~/pminstaller.sh
rm -f ~/pminstaller.sh

# Firefox Adons
# Lastpass
# Full Web Page Screenshots (♥♥♥♥♥)
# Screenshoter (Fixed)


# Spotify
git clone  https://aur.archlinux.org/spotify.git
cd spotify/
makepkg -sri



# Screen brightness / Backlight
ls /sys/class/backlight/
# cat /sys/class/backlight/intel_backlight/max_brightness 
# 4882

# Change
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 1000
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 2000
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 3000
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 4882






# ----------------------------------------------------------------------
# NVIDIA
# ----------------------------------------------------------------------
# https://wiki.archlinux.org/index.php/NVIDIA#Installation

lspci -k | grep -A 2 -E "(VGA|3D)"
# 01:00.0 3D controller: NVIDIA Corporation GK107M [GeForce GT 740M] (rev a1)


# https://nouveau.freedesktop.org/wiki/CodeNames/
# ---------------------------------------------------

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
# Version: 	375.39
# Release Date: 	2017.2.14
# Operating System: 	Linux 64-bit
# Language: 	English (US)
# File Size: 	73.68 MB

# More information
# ---------------------------------------------------

# https://en.wikipedia.org/wiki/GeForce_700_series
# Code name: GK107
# Launch: April 1, 2013
# Fab: 28
# BUS: PCIe 3.0 x16
# Core config: 384:32:16

# Next
# ---------------------------------------------------

# 3. Install the appropriate driver for your card:
#    - For GeForce 400 series cards and newer [NVCx and newer], install the nvidia or nvidia-lts package. If these packages do not work, nvidia-betaAUR may have a newer driver version that offers support.
# https://www.archlinux.org/packages/extra/x86_64/nvidia/
# https://www.archlinux.org/packages/extra/x86_64/nvidia-lts/
# https://aur.archlinux.org/packages/nvidia-beta/

# NOTE: In my personal opinion I should install the nvidia-beta because we have more options, checks "Required by (15)" section, for example:
# - ffmpeg-nvenc. Complete solution to record, convert and stream audio and video with Nvidia CUDA Hardware Acceleration
# - cpyrit-cuda: Pyrit support for Nvidia-CUDA.
# - hoomd-blue: A general-purpose particle simulation toolkit using GPUs with CUDA.

sudo pacman -S linux-headers

cd ~/Downloads/

git clone https://aur.archlinux.org/nvidia-utils-beta.git
cd ~/Downloads/nvidia-utils-beta
makepkg --check
makepkg -si

git clone https://aur.archlinux.org/nvidia-beta.git
cd ~/Downloads/nvidia-beta
makepkg --check
makepkg -si

git clone https://aur.archlinux.org/nvidia-xrun.git
cd ~/Downloads/nvidia-xrun
sudo pacman -S bbswitch
makepkg --check
makepkg -si


# Set up nvidia-xinitrc
# Add this lines: 
xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112
setxkbmap -model pc105 -layout latam -variant ,deadtilde
openbox-session
# OR Execute this line
# echo -e "xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112\nsetxkbmap -model pc105 -layout latam -variant ,deadtilde\nopenbox-session\n" | sudo tee ~/.nvidia-xinitrc > /dev/null

# WARNING: libpng warning: iCCP: known incorrect sRGB profile
# https://wiki.archlinux.org/index.php/Libpng_errors
# convert -strip input_filename output_filename


# (WW) NVIDIA(0): Unable to get display device for DPI computation
# NVIDIA(0): DPI set to (75, 75); computed from built-in default
sudo nvidia-xconfig




# Get DPIs:

xrandr | grep -w connected
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
xrandr
xrandr | grep -w connected

# Create your xrandr configurations, right now you have all the information.
xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112

# Check the output. IMPORTANT: At this point you wouldn't see any changes.
xdpyinfo | grep -B2 resolution
#screen #0:
#  dimensions:    1366x768 pixels (309x174 millimeters)
#  resolution:    112x112 dots per inch



# If you are on laptop, it might be a good idea to install and enable the acpid daemon instead. 
# https://wiki.archlinux.org/index.php/NVIDIA/Tips_and_tricks#Manual_configuration
# https://wiki.archlinux.org/index.php/Acpid
sudo pacman -S acpid
systemctl start acpid.service

# (WW) The directory "/usr/share/fonts/Type1/" does not exist.
sudo pacman -S xorg-fonts-type1

# Change the font type
# https://wiki.archlinux.org/index.php/Font_configuration
# http://news.softpedia.com/news/How-to-Add-Beautiful-Fonts-to-Any-Linux-Distribution-434835.shtml

# (WW) Open ACPI failed (/var/run/acpid.socket) (No such file or directory)
# https://bbs.archlinux.org/viewtopic.php?id=64039


# Close all the startX with `killall -15 Xorg`, then you shouldn't use startx any more you need nvidia-xrun
# Login / Password
nvidia-xrun


cd ~/Downloads/
rm -fR ~/Downloads/nvidia-utils-beta ~/Downloads/nvidia-beta ~/Downloads/nvidia-xrun






# Install Media Players
sudo pacman -S --noconfirm parole
sudo pacman -S --noconfirm gst-libav



# Add keyword events
echo -e '#!/bin/sh\namixer -q sset Master 5%+' | sudo tee /etc/acpi/events/volumeup > /dev/null
sudo chmod +x /etc/acpi/events/volumeup
echo -e '#!/bin/sh\namixer -q sset Master 5%-' | sudo tee /etc/acpi/events/volumedown > /dev/null
sudo chmod +x /etc/acpi/events/volumedown
echo -e '#!/bin/sh\namixer -q sset Master toggle' | sudo tee /etc/acpi/events/volumemute > /dev/null
sudo chmod +x /etc/acpi/events/volumemute
sudo acpid restart












# Create Mirror List Server by speed and with the protocol https at least 10 servers
sudo reflector --country 'United States' --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Force pacman to refresh the package lists
sudo pacman -Syyu  --noconfirm




# https://wiki.archlinux.org/index.php/Xbindkeys
# touch ~/.xbindkeysrc
xbindkeys -d > ~/.xbindkeysrc

# Identifying keycodes
xbindkeys -k

# Reload the configuration file and apply the changes
xbindkeys -p
xbindkeys


##################################
# End of xbindkeys configuration #
##################################

# Increase volume
"amixer -q sset Master 5%+"
   XF86AudioRaiseVolume

# Decrease volume
"amixer -q sset Master 5%-"
   XF86AudioLowerVolume

# Mute/Unmute volumen
"amixer -q sset Master toggle"
   XF86AudioMute
