#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Config
# ----------------------------------------------------------------------
# Set the configuration variables to us in all the scripts
yourComputerName="MSI_GT73EVR_7RF"
yourUserName="wolf"


# ----------------------------------------------------------------------
# Load sub sources
# ----------------------------------------------------------------------
sourceDirectory=$(dirname $BASH_SOURCE)/
source "$sourceDirectory"00-functions.sh

PS4=\
'


Line #${LINENO}
BASH_COMMAND: ${BASH_COMMAND}
--------------------------------------------------------------------------------
'

set -x
