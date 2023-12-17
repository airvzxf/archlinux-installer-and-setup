#!/usr/bin/env bash
set -ve

# ----------------------------------------------------------------------
# Arch Linux :: Set up - Graphics system
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

source ./../00-configuration.bash

funcIsConnectedToInternet

# ----------- #
# SET UP XORG #
# ----------- #

# ------------------- #
# Set up the generals #
# ------------------- #

# Install Xorg fonts.
# Install the Xorg X server.
# Install the X.Org initialisation program.
# Install Xorg xrandr.
# Install the Xorg xdisplay info.
# Install the X.Org authorization settings program.
# Install the lightweight passphrase dialog for SSH.
# Install the randR-based backlight control application.
# Install the highly configurable and lightweight X11 window manager.
# Install the turns on the numlock key in X11.
# Install the X Terminal Emulator.
# Install the launch shell commands with your keyboard or your mouse under X.
sudo pacman --sync --needed --noconfirm \
  xorg-font-util xorg-fonts-alias-100dpi xorg-fonts-100dpi xorg-fonts-alias-75dpi \
  xorg-fonts-75dpi xorg-fonts-alias-cyrillic xorg-fonts-cyrillic xorg-fonts-alias-misc \
  xorg-fonts-misc xorg-fonts-encodings xorg-fonts-type1 \
  xorg-server xorg-server-devel xorg-xinit xorg-xrandr xorg-xdpyinfo xorg-xauth \
  x11-ssh-askpass xorg-xbacklight openbox numlockx xterm xbindkeys

# Set up the Xbind keys.
# The command 'xmodmap', shows the keymaps and button mappings.
# Refresh the bind keys
xbindkeys --poll-rc

# Add the user into the TTY group.
sudo gpasswd -a "${userId}" tty

# -------------------------------- #
# Set up the automatic user log in #
# -------------------------------- #

# Create the folder.
sudo mkdir --parents /etc/systemd/system/getty@tty1.service.d/

# Create the system service for log-in automatically.
echo "[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin ${userId} %I ${TERM}
" | sudo tee /etc/systemd/system/getty@tty1.service.d/autologin.conf

# -------- #
# Finished #
# -------- #

# The next step is set up NVIDIA.
# Execute './03a01-graphic-card-nvidia.bash'.
