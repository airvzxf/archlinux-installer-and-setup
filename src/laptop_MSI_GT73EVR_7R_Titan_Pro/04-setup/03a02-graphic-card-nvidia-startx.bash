#!/bin/bash
source 00-config.bash

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

echo -e ""
echo -e "Kill Xorg if it's opened"
sudo killall -15 Xorg
echo -e ""

echo -e "Run Openbox with Nvidia drivers"
xinit

echo -e "Ready! The next step is run './03a03-graphic-card-nvidia-gui.bash'.\n"
echo -e "Finished successfully!"
echo -e ""
