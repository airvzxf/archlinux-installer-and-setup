#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Sart the openbox window manager
# ----------------------------------------------------------------------

# Close all the startX with 'killall -15 Xorg', then you shouldn't use
# startx any more you need nvidia-xrun
funcIsConnectedToInternet
sudo killall -15 Xorg
nvidia-xrun
