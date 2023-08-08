#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

# ----------------------------------------------------------------------
# Steam - Payday 2
# ----------------------------------------------------------------------

# Game does not start
# http://steamcommunity.com/app/218620/discussions/22/350544272215417292/

# https://aur.archlinux.org/packages/blt4l-runtime-bin/
# https://github.com/blt4linux/blt4l
yay -S --needed --noconfirm blt4l-runtime-bin

# No audio
sudo pacman --sync --needed --noconfirm pulseaudio
# And reboot to make effect.

# Wikis
# http://payday.wikia.com/wiki/Category:PAYDAY_2_heists
# http://payday.wikia.com/wiki/Weapons_%28Payday_2%29
# http://payday.wikia.com/wiki/Armors
# http://payday.wikia.com/wiki/Skills
# http://payday.wikia.com/wiki/Perk_Decks
# http://payday.wikia.com/wiki/Category:Special_enemies_%28Payday_2%29
# http://payday.wikia.com/wiki/Safe_House
# http://payday.wikia.com/wiki/Gage_Mod_Courier
