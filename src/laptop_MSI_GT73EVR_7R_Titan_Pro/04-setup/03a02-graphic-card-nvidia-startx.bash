#!/usr/bin/env bash
set -ve

# ----------------------------------------------------------------------
# Arch Linux :: Setup - NVIDIA step 2 / 3
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

source ./../00-configuration.bash

funcIsConnectedToInternet

# -------------------------------- #
# START THE OPENBOX WINDOW MANAGER #
# -------------------------------- #

# Kill Xorg if it's opened.
sudo killall -15 Xorg || true

# Run Openbox with Nvidia drivers.
xinit

# -------- #
# Finished #
# -------- #

# The next step is set up basic packages in GUI Desktop.
# Execute './04-basic-gui.bash'.
