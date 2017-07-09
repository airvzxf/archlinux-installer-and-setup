#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# After install Nvidia
# ----------------------------------------------------------------------
# Then login to your session and execute this commands in the windows
# terminal (konsole).
# When you start
sudo nvidia-xconfig
systemctl start acpid.service
