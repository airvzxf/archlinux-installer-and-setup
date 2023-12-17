#!/usr/bin/env bash
set -ve

# ----------------------------------------------------------------------
# Arch Linux :: Set up - Basics GUI
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

# ----------- #
# VIDEO GAMES #
# ----------- #

source ./../00-configuration.bash

funcIsConnectedToInternet

# ----- #
# Steam #
# ----- #
# https://wiki.archlinux.org/index.php/Steam
# https://wiki.archlinux.org/index.php/Steam/Troubleshooting
# https://wiki.archlinux.org/index.php/Steam/Game-specific_troubleshooting
# https://wiki.archlinux.org/index.php/Gamepad

# Enable MultiLib in Pacman.
# Run and build 32-bit applications on 64-bit installations of Arch Linux.
# https://wiki.archlinux.org/index.php/Multilib

# Upgrade Arch Linux.
sudo pacman --sync --refresh --refresh --sysupgrade --noconfirm

# Install the NVIDIA drivers utilities.
# Install the NVIDIA drivers utilities (32-bit).
# Install the Valve's digital software delivery system.
# ----------------- #
# Missing libraries #
# ----------------- #
# Run steam then if you got these errors:
# - libGL error: No matching fbConfigs or visuals found.
# - libGL error: failed to load a driver: swrast.
# Install the NVIDIA drivers utilities (32-bit).
# Install the X11 Testing -- Resource extension library (32-bit).
# libXtst.so.6 => not found.
# Install the library for passing menus over DBus (32-bit).
# libgio-2.0.so.0 => not found.
# libglib-2.0.so.0 => not found.
# libgobject-2.0.so.0 => not found.
# Install the Library for configuring and customizing font access.
# libfontconfig.so.1 => not found.
# libfreetype.so.6 => not found.
# Install an image loading library (32-bit).
# libgdk_pixbuf-2.0.so.0 => not found.
# Install the cross-platform 3D audio library, software implementation (32-bit).
# libopenal.so.1 => not found.
# Install the X11 RandR extension library (32-bit).
# libXrandr.so.2 => not found.
# Install the X11 Xinerama extension library (32-bit).
# libXinerama.so.1 => not found.
# Install a cross-platform user library to access USB devices (32-bit).
# libusb-1.0.so.0 => not found.
# Install the libudev.so.0 compatibility library for systems with newer udev versions (32 bit).
# libudev.so.0 => not found.
# Install the X11 Session Management library (32-bit).
# libICE.so.6 => not found.
# libSM.so.6 => not found.
# Install A featureful, general-purpose sound server (32-bit client libraries).
# libpulse.so.0 => not found.
# Install the NetworkManager client library (32-bit).
# libdbus-glib-1.so.2 => not found.
# libnm-glib.so.4 => not found.
# libnm-util.so.2 => not found.
# Install the GObject-based multi-platform GUI toolkit (legacy) (32-bit).
# libgtk-x11-2.0.so.0 => not found.
# --------------- #
# Other libraries #
# --------------- #
# Install the FreeType-based font drawing library for X (32-bit).
# Install the font rasterization library (32-bit).
# Install a collection of routines used to create PNG format graphics files.
# Install the Video Acceleration (VA) API for Linux (32-bit).
# Install the NVIDIA VDPAU library.
# Install the complete solution to record, convert, and stream audio and video.
# Install the low-latency audio/video router and processor - 32-bit - client library.
# Install a library for portable low-level access to a video framebuffer, audio output, mouse, and keyboard.
sudo pacman --sync --needed --noconfirm \
  nvidia-libgl lib32-nvidia-libgl steam lib32-nvidia-utils lib32-libxtst lib32-libdbusmenu-glib \
  lib32-fontconfig lib32-gdk-pixbuf2 lib32-openal lib32-libxrandr lib32-libxinerama lib32-libusb \
  lib32-libudev0-shim lib32-libsm lib32-libpulse lib32-libnm lib32-gtk2 lib32-libxft \
  lib32-freetype2 lib32-libpng12 lib32-libva lib32-libvdpau ffmpeg4.4 lib32-libpipewire lib32-sdl2

# --------------------- #
# Set up the controller #
# --------------------- #

# Added the controller in UDev.
echo -e "
# Valve USB devices.
SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"28de\", MODE=\"0666\"

# Steam Controller udev write access.
KERNEL==\"uinput\", SUBSYSTEM==\"misc\", TAG+=\"uaccess\"

# HTC Vive HID Sensor naming and permission.

# Valve HID devices over USB hidraw.
KERNEL==\"hidraw*\", ATTRS{idVendor}==\"28de\", MODE=\"0666\"

# Valve HID devices over bluetooth hidraw.
KERNEL==\"hidraw*\", KERNELS==\"*28DE:*\", MODE=\"0666\"
" | sudo tee /lib/udev/rules.d/99-steam-controller-perms.rules

# ---------------------- #
# Scan missing libraries #
# ---------------------- #

# Run steam for the first time.
steam

# Steam has a good commands to check all the missing libraries.
# All these libraries should be there in MultiLib repositories.
# Show missing libraries in Steam.
cd ~/.local/share/Steam/ubuntu12_32 || funcDirectoryNotExist
chmod +x libx264.so.142
file ./* | grep ELF | cut -d: -f1 | LD_LIBRARY_PATH=. xargs ldd | grep 'not found' | sort | uniq

# -------- #
# Finished #
# -------- #

# The next step is set up video games.
# Execute './06-suggestions.bash'.
