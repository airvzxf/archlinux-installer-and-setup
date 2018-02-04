#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Information
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# CLion
# [DON'T EXECUTE THIS SCRIPT, IS ONLY INFORMATIVE]
# ----------------------------------------------------------------------

sudo rm /usr/local/bin/clion*
cLionDir='/home/wolf/workspace/packages/clion/bin'
sudo ln -s $cLionDir/clion.sh /usr/local/bin/clion.sh
sudo ln -s $cLionDir/restart.py /usr/local/bin/clion-restart
sudo ln -s $cLionDir/format.sh /usr/local/bin/clion-formatter
sudo ln -s $cLionDir/inspect.sh /usr/local/bin/clion-inspector
sudo ln -s $cLionDir/printenv.py /usr/local/bin/clion-env
