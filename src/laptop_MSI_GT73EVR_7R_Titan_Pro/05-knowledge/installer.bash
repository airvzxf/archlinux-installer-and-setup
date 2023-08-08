#!/bin/bash

# Screen brightness / Backlight
ls /sys/class/backlight/
# cat /sys/class/backlight/intel_backlight/max_brightness
# 4882

# Change
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 1000
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 2000
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 3000
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 4000
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 4882


# Add keyword events
echo -e '#!/bin/sh\namixer -q sset Master 5%+' | sudo tee /etc/acpi/events/volumeup > /dev/null
sudo chmod +x /etc/acpi/events/volumeup
echo -e '#!/bin/sh\namixer -q sset Master 5%-' | sudo tee /etc/acpi/events/volumedown > /dev/null
sudo chmod +x /etc/acpi/events/volumedown
echo -e '#!/bin/sh\namixer -q sset Master toggle' | sudo tee /etc/acpi/events/volumemute > /dev/null
sudo chmod +x /etc/acpi/events/volumemute
sudo acpid restart


# Increase volume
"amixer -q sset Master 5%+"
   XF86AudioRaiseVolume

# Decrease volume
"amixer -q sset Master 5%-"
   XF86AudioLowerVolume

# Mute/Unmute volumen
"amixer -q sset Master toggle"
   XF86AudioMute



# GEANY
# ----------------------------------------------------------------------
# Check how to config with command lines
# Does not show whitespace by default. Visible whitespace can be toggled using the View > Editor > Show White Space option.
# Trims trailing whitespace on file save when the "Strip trailing spaces and tabs" option is enabled (Preferences->Files->Saving Files, Check all options EXCEPT convert tabs to whit spaces)
# ?? Maybe not: Preferences->Editor-Feachures, Check newline strip

# Partial upgrades are unsupported
# https://wiki.archlinux.org/index.php/System_maintenance#Partial_upgrades_are_unsupported
#sudo pacman -Syu

# Install python pip
sudo pacman -S python-pip

# Markdown viewer
sudo pip install grip
#grip -b ./
#grip -b fine_name

