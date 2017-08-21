#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Steam - Amnesia: The Dark Descent
# ----------------------------------------------------------------------

# Tricks and Hacks
cd ~/.frictionalgames/Amnesia/Main/[userNameInTheGame]
# Then ls and you see all your save files, open the last one and modify
# <var type="2" name="mlTinderboxes" val="99" />   Unlimited Tinderboxes
# <var type="3" name="mfHealth" val="9999.000000" />    Unlimited Health
# <var type="3" name="mfLampOil" val="9999.000000" />   Unlimited Oil
# <var type="3" name="mfSanity" val="9999.000000" />    Unlimited Sanity

# Walkthrough
# https://www.gamefaqs.com/pc/978772-amnesia-the-dark-descent/faqs/60874


# Errors!

# Can't set the specified locale! Check LANG, LC_CTYPE, LC_ALL.
# Uncomment en_US.UTF-8 UTF-8 and other needed localizations in /etc/locale.gen, and generate them with:
sudo sed -i '/en_US.UTF-8 UTF-8/ s/^##*//' /etc/locale.gen
sudo locale-gen
