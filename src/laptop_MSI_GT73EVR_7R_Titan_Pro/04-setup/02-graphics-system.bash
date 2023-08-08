#!/bin/bash
set -ve

# ----------------------------------------------------------------------
# Arch Linux :: Set up - Graphics system
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

source ./../00-configuration.bash

funcIsConnectedToInternet

# ----------- #
# SET UP XORG #
# ----------- #

# ------------------- #
# Set up the generals #
# ------------------- #

# Install the X Terminal Emulator.
funcInstallPacmanPackageAndDependencies xterm

# Install Xorg fonts.
funcInstallPacmanPackageAndDependencies xorg-fonts-100dpi
funcInstallPacmanPackageAndDependencies xorg-fonts-75dpi
funcInstallPacmanPackageAndDependencies xorg-fonts-alias-100dpi
funcInstallPacmanPackageAndDependencies xorg-fonts-alias-75dpi
funcInstallPacmanPackageAndDependencies xorg-fonts-alias-cyrillic
funcInstallPacmanPackageAndDependencies xorg-fonts-alias-misc
funcInstallPacmanPackageAndDependencies xorg-fonts-cyrillic
funcInstallPacmanPackageAndDependencies xorg-fonts-encodings
funcInstallPacmanPackageAndDependencies xorg-fonts-misc
funcInstallPacmanPackageAndDependencies xorg-fonts-type1

# Install a backward-compatible xbacklight replacement based on ACPI.
sudo pacman -S --needed --noconfirm acpilight

# Install Xorg.
sudo pacman -S --needed --noconfirm xorg

# Install the X.Org initialisation program.
funcInstallPacmanPackageAndDependencies xorg-xinit

# Install Xorg xrandr.
funcInstallPacmanPackageAndDependencies xorg-xrandr

# Install the Xorg xdisplay info.
funcInstallPacmanPackageAndDependencies xorg-xdpyinfo

# Install the Highly configurable and lightweight X11 window manager.
sudo pacman -S --needed --noconfirm openbox

# Install the turns on the numlock key in X11.
funcInstallPacmanPackageAndDependencies numlockx

# Xbindkeys
# https://wiki.archlinux.org/index.php/Xbindkeys

# Install the launch shell commands with your keyboard or your mouse under X.
funcInstallPacmanPackageAndDependencies xbindkeys

# Set up the Xbind keys.
# The command 'xmodmap', show the keymaps and button mappings.
echo -e \
'# Increase volume
"pactl set-sink-volume @DEFAULT_SINK@ +5%"
   XF86AudioRaiseVolume
"pactl set-sink-volume @DEFAULT_SINK@ +5%"
  m:0x50 + c:133
  Mod2+Mod4 + Super_L
  m:0x50 + c:114
  Mod2+Mod4 + Right

# Decrease volume
"pactl set-sink-volume @DEFAULT_SINK@ -5%"
   XF86AudioLowerVolume

# Mute volume
"pactl set-sink-mute @DEFAULT_SINK@ toggle"
   XF86AudioMute

# Mute microphone
"pactl set-source-mute @DEFAULT_SOURCE@ toggle"
   XF86AudioMicMute

# Increase brightness
"xbacklight -set -5"
   XF86MonBrightnessDown

# Decrease brightness
"xbacklight -set +5"
   XF86MonBrightnessUp
' | tee ~/.xbindkeysrc

# Refresh the bind keys
xbindkeys --poll-rc

# Solving Xorg warnings: mkfontdir in font dpis.
#sudo mkfontdir /usr/share/fonts/100dpi/
#sudo mkfontdir /usr/share/fonts/75dpi/

# Install a modern, hackable, featureful, OpenGL-based terminal emulator.
#funcInstallPacmanPackageAndDependencies --exclude imagemagick libcanberra --packages kitty
#cp -p ~/.config/kitty/kitty.conf ~/.config/kitty/kitty-backup.conf

# -------- #
# Finished #
# -------- #

# The next step is set up NVIDIA.
# Execute './03a01-graphic-card-nvidia.bash'.
