#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Steam information and errors
# ----------------------------------------------------------------------

# Steam/Troubleshooting
# https://wiki.archlinux.org/index.php/Steam/Troubleshooting#Steam_runtime_issues

# If you are looking for what libraries are missing
# Installation steam without UI, then if you run steam-native it show the missing libraries
steam -textclient

# Error with cannot connect with Steam
# opensslconnection.cpp (1393) : Assertion Failed: unable to load trusted SSL root certificates
# Assert( Assertion Failed: unable to load trusted SSL root certificates ):opensslconnection.cpp:1393
sudo pacman -S --force ca-certificates-utils

# Remove Steam
sudo pacman -Rs steam
# Or
sudo pacman -Rsc steam


# If some game not work, try that first
# To set custom launch options for a game, right-click on it in your library, select Properties and click on the Set Launch Options button.
# Add to your launch options:
# LD_LIBRARY_PATH="/usr/lib:$LD_LIBRARY_PATH"
# LD_LIBRARY_PATH=/usr/lib/openssl-1.0-compat


# Errors and warnings
# ----------------------------------------------------------------------
# https://wiki.archlinux.org/index.php/Steam/Troubleshooting#Configure_PulseAudio
# Solved with the correct configuration in ~/.asoundrc


# Can't set the specified locale! Check LANG, LC_CTYPE, LC_ALL.
# Uncomment en_US.UTF-8 and other needed localizations in /etc/locale.gen, and generate them with:
sudo sed --in-place '/en_US.UTF-8 UTF-8/ s/^##*//' /etc/locale.gen
sudo locale-gen



# Other errors
# ----------------------------------------------------------------------

# ERROR: ld.so: object '~/.local/share/Steam/ubuntu12_64/gameoverlayrenderer.so' from LD_PRELOAD cannot be preloaded (wrong ELF class: ELFCLASS64): ignored.

# This can be fixed, however, by forcing the game to use a later version of OpenGL than it wants. Right click on the game, select Properties. Then, click "Set Launch Options" in the "General" tab and paste the following:
# MESA_GL_VERSION_OVERRIDE=3.1 MESA_GLSL_VERSION_OVERRIDE=140 %command%

# Setup with multiple monitors can cause error which will make game unable to start. If you stuck on this error and have multiple monitors, try to disable all additional displays, and then run a game. You can enable them after the game successfully started.
export LD_LIBRARY_PATH=/usr/lib32/nvidia:/usr/lib/nvidia:$LD_LIBRARY_PATH


# Information
# ----------------------------------------------------------------------

# Recommended this way to use USB controllers (Steam Big Picture)
# Play with any USB controller on Linux using Steam Big Picture
# http://steamcommunity.com/app/221410/discussions/0/558748822569010381/

# Play with any USB controller on Linux using xboxdrv to emulate a XBOX controller
# https://steamcommunity.com/app/221410/discussions/0/558748653738497361/
