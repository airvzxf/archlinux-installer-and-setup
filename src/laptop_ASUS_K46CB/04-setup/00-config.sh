#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Config
# ----------------------------------------------------------------------
# Set the configuration variables to us in all the scripts
yourComputerName="wolfMachine"
yourUserName="wolf"


# ----------------------------------------------------------------------
# Load sub sources
# ----------------------------------------------------------------------
sourceDirectory=$(dirname $BASH_SOURCE)/
source "$sourceDirectory"00-functions.sh
