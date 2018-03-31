#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Steam
# ----------------------------------------------------------------------
# https://wiki.archlinux.org/index.php/Steam
# https://wiki.archlinux.org/index.php/Steam/Troubleshooting
# https://wiki.archlinux.org/index.php/Steam/Game-specific_troubleshooting
# https://wiki.archlinux.org/index.php/Gamepad
funcIsConnectedToInternet

# Install packages
echo -e "Installing lib openssl"
echo -e ""
#yaourt -S --needed lib32-libopenssl-1.0-compat
echo -e "\n"

echo -e "Installing nvidia"
echo -e ""
sudo pacman -S --needed --noconfirm nvidia
echo -e "\n"

echo -e "Installing nvidia"
echo -e ""
sudo pacman -S --needed --noconfirm nvidia-utils
echo -e "\n"

echo -e "Installing nvidia lib32 LG"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-nvidia-libgl
echo -e "\n"

echo -e "Installing nvidia lib GL"
echo -e ""
sudo pacman -S --needed --noconfirm nvidia-libgl
echo -e "\n"

echo -e "Installing Steam"
echo -e ""
sudo pacman -S --needed --noconfirm steam
echo -e "Open steam package wait to lunch the app and login into your account, please close when you finished"
echo -e ""
steam
echo -e "\n"

#~ echo -e "Installing Steam native runtime"
#~ echo -e ""
#~ sudo pacman -S --needed --noconfirm steam-native-runtime
#~ echo -e "\n"

# Setup controller
# ----------------------------------------------------------------------
steam_controller_rules=/lib/udev/rules.d/99-steam-controller-perms.rules

echo -e \
'# Valve USB devices
SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"

# Steam Controller udev write access
KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess"

# HTC Vive HID Sensor naming and permissioning

# Valve HID devices over USB hidraw
KERNEL=="hidraw*", ATTRS{idVendor}=="28de", MODE="0666"

# Valve HID devices over bluetooth hidraw
KERNEL=="hidraw*", KERNELS=="*28DE:*", MODE="0666"' | sudo tee ${steam_controller_rules}


# Missing libraries
# ----------------------------------------------------------------------

# Run steam, if you got this errors
# libGL error: No matching fbConfigs or visuals found
# libGL error: failed to load driver: swrast
echo -e "Installing nvidia lib32 utils"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-nvidia-utils
echo -e "\n"

# Steam has a good commands to check all the missing libraries
# All this libraries should be there in MultiLib repositories
echo -e "Show missing libraries in Steam"
echo -e ""
cd ~/.local/share/Steam/ubuntu12_32
chmod +x libx264.so.142
file * | grep ELF | cut -d: -f1 | LD_LIBRARY_PATH=. xargs ldd | grep 'not found' | sort | uniq
echo -e "\n"

# libXtst.so.6 => not found
echo -e "Installing lib32 Xtst"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-libxtst
echo -e "\n"

# libgio-2.0.so.0 => not found
# libglib-2.0.so.0 => not found
# libgobject-2.0.so.0 => not found
echo -e "Installing lib32  bus menu GLib"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-libdbusmenu-glib
echo -e "\n"

# libfontconfig.so.1 => not found
# libfreetype.so.6 => not found
echo -e "Installing lib32 font config"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-fontconfig
echo -e "\n"

# libgdk_pixbuf-2.0.so.0 => not found
echo -e "Installing lib32 pix buf"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-gdk-pixbuf2
echo -e "\n"

# libopenal.so.1 => not found
echo -e "Installing lib32 openal"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-openal
echo -e "\n"

# libXrandr.so.2 => not found
echo -e "Installing lib32 xrandr"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-libxrandr
echo -e "\n"

# libXinerama.so.1 => not found
echo -e "Installing lib32 xinerama"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-libxinerama
echo -e "\n"

# libusb-1.0.so.0 => not found
echo -e "Installing spotify"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-libusb
echo -e "\n"

# libudev.so.0 => not found
echo -e "Installing lib32 udev"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-libudev0-shim
echo -e "\n"

# libICE.so.6 => not found
# libSM.so.6 => not found
echo -e "Installing spotify"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-libsm
echo -e "\n"

# libpulse.so.0 => not found
echo -e "Installing lib32 pulse"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-libpulse
echo -e "\n"

# libdbus-glib-1.so.2 => not found
# libnm-glib.so.4 => not found
# libnm-util.so.2 => not found
echo -e "Installing lib32 NM"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-libnm-glib
echo -e "\n"

# libgtk-x11-2.0.so.0 => not found
echo -e "Installing lib32 GTK2"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-gtk2
echo -e "\n"

# Others
echo -e "Installing lib32 Xft"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-libxft
echo -e "\n"

echo -e "Installing lib32 free type"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-freetype2
echo -e "\n"

echo -e "Installing lib32 png12"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-libpng12
echo -e "\n"

echo -e "Installing lib32 libva"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-libva
echo -e "\n"

echo -e "Installing lib32 libvdpau"
echo -e ""
sudo pacman -S --needed --noconfirm lib32-libvdpau
echo -e "\n"


echo -e "Congrats! You were install and setup Arch Linux."
echo -e ""
