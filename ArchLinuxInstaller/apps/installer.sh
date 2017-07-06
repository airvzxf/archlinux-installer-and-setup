#!/bin/bash

# Laptop main page contains links to article.
# https://wiki.archlinux.org/index.php/Laptop

# List of applications
# https://wiki.archlinux.org/index.php/List_of_applications

# Codecs
# https://wiki.archlinux.org/index.php/Codecs


# Update Repositories
sudo pacman -Syu

# Uninstall Repositories
sudo pacman -R #[package_name]


# Install yaourt: a pacman frontend which install the AUR packages.
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..

# Yaourt GUI 
yaourt -S yaourt-gui
yaourt -S pamac-aur




# Keyboard configuration in Xorg
# https://wiki.archlinux.org/index.php/Keyboard_configuration_in_Xorg
# Dislpay information
setxkbmap -print -verbose 10
localectl list-x11-keymap-layouts | grep lat
localectl list-x11-keymap-variants latam

# Setup the configuration
localectl --no-convert set-x11-keymap latam pc105 ,deadtilde


pacman -Syuw                           # download packages
rm /etc/ssl/certs/ca-certificates.crt  # remove conflicting file
pacman -Su                             # perform upgradepacman -Rdd ca-certificates-utils
pacman -Rdd ca-certificates-utils
pacman -S ca-certificates-utils
pacman -Syu


# Multilib
# Run and build 32-bit applications on 64-bit installations of Arch Linux. 
# https://wiki.archlinux.org/index.php/Multilib
sudo nano /etc/pacman.conf
# Uncomment the line below of [multilib]
# Include = /etc/pacman.d/mirrorlist
sudo pacman -Syu


# Problems with AUR keys when add or delete packages
# Example: vlc-2.2.4.tar.xz ... FAILED (unknown public key 7180713BE58D1ADC)
# Solve:
# gpg --recv-keys 7180713BE58D1ADC

# Commands
# Show the installed packages and their versions
sudo pacman -Q



# Pacman always with color:
sudo nano /etc/pacman.conf
# Uncomment below: # Misc options
# Color


# Common applications for the OS
sudo pacman -Syu
sudo pacman -S --noconfirm base-devel sudo
sudo pacman -S --noconfirm xdotool
sudo pacman -S --noconfirm xbindkeys
sudo pacman -S --noconfirm reflector
sudo pacman -S --noconfirm git


# Other utilities
sudo pacman -S xfce4-screenshooter # Screenshots

sudo pacman -S hdparm #List brand and properties for your HHD
sudo hdparm -I /dev/sda






# Alsa tutorial
# https://wiki.gentoo.org/wiki/ALSA
#-----------------------------------------------------------------------
sudo pacman -S --noconfirm alsa-utils

# Useful commands
speaker-test -c2 -twav -l1
aplay -L
aplay --list-devices
amixer controls | grep Master
cat /sys/class/sound/card*/id
cat /proc/asound/card0/pcm0p/info
cat /proc/asound/card0/pcm3p/info




# Productive applications
sudo pacman -S --noconfirm epdfview # PDF Viewer

# Development applications
sudo pacman -S --noconfirm atom
#useHardwareAcceleration: false

# Bit Torrent
sudo pacman -S --noconfirm transmission-gtk




# Pale Moon web browser
cp palemoon/pminstaller.sh ~/
~/pminstaller.sh
rm -f ~/pminstaller.sh

# Firefox Adons
# Lastpass
# Full Web Page Screenshots (♥♥♥♥♥)
# Screenshoter (Fixed)


# Spotify
git clone  https://aur.archlinux.org/spotify.git
cd spotify/
makepkg -sri





# Screen brightness / Backlight
ls /sys/class/backlight/
# cat /sys/class/backlight/intel_backlight/max_brightness 
# 4882

# Change
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 1000
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 2000
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 3000
sudo tee /sys/class/backlight/intel_backlight/brightness <<< 4882





# ----------------------------------------------------------------------
# NVIDIA UPGRADE PACMAN
# ----------------------------------------------------------------------
# When upgrade pacman some time we lost the nvidia drivers we need to re-install that.
sudo pacman -S linux-headers

cd ~/Downloads/

git clone https://aur.archlinux.org/nvidia-utils-beta.git
cd ~/Downloads/nvidia-utils-beta
makepkg --check
makepkg -si

git clone https://aur.archlinux.org/nvidia-beta.git
cd ~/Downloads/nvidia-beta
makepkg --check
makepkg -si



# ----------------------------------------------------------------------
# NVIDIA
# ----------------------------------------------------------------------
# https://wiki.archlinux.org/index.php/NVIDIA#Installation

lspci -k | grep -A 2 -E "(VGA|3D)"
# 01:00.0 3D controller: NVIDIA Corporation GK107M [GeForce GT 740M] (rev a1)


# https://nouveau.freedesktop.org/wiki/CodeNames/
# ---------------------------------------------------

# Code name: NVE0
# Official Name: GeForce 600, GeForce 700, GeForce GTX Titan
# Nvidia 3D object codename: Kepler
# Some 6xx & 7xx series cards are from the NVC0 family instead.

# NVE0 family (Kepler)
# First family to support using 4 monitors simultaneously on one GPU, older generations had only 2 CRTCs.
# NVE7 (GK107)
# GeForce GT (640[M], 645M, 650M, 710M, 720M, 730M, 740[M], ...

# http://www.nvidia.com/Download/index.aspx
# ---------------------------------------------------

# http://www.nvidia.com/download/driverResults.aspx/114708/en-us
# Linux x64 (AMD64/EM64T) Display Driver 
# Version: 	375.39
# Release Date: 	2017.2.14
# Operating System: 	Linux 64-bit
# Language: 	English (US)
# File Size: 	73.68 MB

# More information
# ---------------------------------------------------

# https://en.wikipedia.org/wiki/GeForce_700_series
# Code name: GK107
# Launch: April 1, 2013
# Fab: 28
# BUS: PCIe 3.0 x16
# Core config: 384:32:16

# Next
# ---------------------------------------------------

# 3. Install the appropriate driver for your card:
#    - For GeForce 400 series cards and newer [NVCx and newer], install the nvidia or nvidia-lts package. If these packages do not work, nvidia-betaAUR may have a newer driver version that offers support.
# https://www.archlinux.org/packages/extra/x86_64/nvidia/
# https://www.archlinux.org/packages/extra/x86_64/nvidia-lts/
# https://aur.archlinux.org/packages/nvidia-beta/

# NOTE: In my personal opinion I should install the nvidia-beta because we have more options, checks "Required by (15)" section, for example:
# - ffmpeg-nvenc. Complete solution to record, convert and stream audio and video with Nvidia CUDA Hardware Acceleration
# - cpyrit-cuda: Pyrit support for Nvidia-CUDA.
# - hoomd-blue: A general-purpose particle simulation toolkit using GPUs with CUDA.

sudo pacman -S linux-headers

cd ~/Downloads/

git clone https://aur.archlinux.org/nvidia-utils-beta.git
cd ~/Downloads/nvidia-utils-beta
makepkg --check
makepkg -si

git clone https://aur.archlinux.org/nvidia-beta.git
cd ~/Downloads/nvidia-beta
makepkg --check
makepkg -si

git clone https://aur.archlinux.org/nvidia-xrun.git
cd ~/Downloads/nvidia-xrun
sudo pacman -S bbswitch
makepkg --check
makepkg -si


# Set up nvidia-xinitrc
# Add this lines: 
xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112
setxkbmap -model pc105 -layout latam -variant ,deadtilde
openbox-session
# OR Execute this line
# echo -e "xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112\nsetxkbmap -model pc105 -layout latam -variant ,deadtilde\nopenbox-session\n" | sudo tee ~/.nvidia-xinitrc > /dev/null

# WARNING: libpng warning: iCCP: known incorrect sRGB profile
# https://wiki.archlinux.org/index.php/Libpng_errors
# convert -strip input_filename output_filename


# (WW) NVIDIA(0): Unable to get display device for DPI computation
# NVIDIA(0): DPI set to (75, 75); computed from built-in default
sudo nvidia-xconfig




# Get DPIs:

xrandr | grep -w connected
# LVDS-1-1 connected 1366x768+0+0 (normal left inverted right x axis y axis) 309mm x 173mm

# Use the information, get the size in millimeters and convert to cm, 
# 309 mm x 173 mm
# 30.9 cm x 17.3 cm

# Get Inches: divide CM between 2.54, always use 2.54
# x = 30.9/2.54 = 12.17 in
# y = 17.3/2.54 = 6.81 in

# Divide the resolution (1366x768) between in (12.17x6.81)
# x = 1366/12.17 = 112.24 dpis
# y = 768/6.81 = 112.78 dpis

# Get information about the screen
xrandr
xrandr | grep -w connected

# Create your xrandr configurations, right now you have all the information.
xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112

# Check the output. IMPORTANT: At this point you wouldn't see any changes.
xdpyinfo | grep -B2 resolution
#screen #0:
#  dimensions:    1366x768 pixels (309x174 millimeters)
#  resolution:    112x112 dots per inch



# If you are on laptop, it might be a good idea to install and enable the acpid daemon instead. 
# https://wiki.archlinux.org/index.php/NVIDIA/Tips_and_tricks#Manual_configuration
# https://wiki.archlinux.org/index.php/Acpid
sudo pacman -S acpid
systemctl start acpid.service

# (WW) The directory "/usr/share/fonts/Type1/" does not exist.
sudo pacman -S xorg-fonts-type1

# Change the font type
# https://wiki.archlinux.org/index.php/Font_configuration
# http://news.softpedia.com/news/How-to-Add-Beautiful-Fonts-to-Any-Linux-Distribution-434835.shtml

# (WW) Open ACPI failed (/var/run/acpid.socket) (No such file or directory)
# https://bbs.archlinux.org/viewtopic.php?id=64039


# Close all the startX with `killall -15 Xorg`, then you shouldn't use startx any more you need nvidia-xrun
# Login / Password
nvidia-xrun


cd ~/Downloads/
rm -fR ~/Downloads/nvidia-utils-beta ~/Downloads/nvidia-beta ~/Downloads/nvidia-xrun






# Install Media Players
sudo pacman -S --noconfirm parole
sudo pacman -S --noconfirm gst-libav



# Install Boinc
########################################################################
sudo pacman -S boinc

# Install libraries
sudo pacman -S lib32-glibc lib32-glib2 lib32-pango lib32-libxi lib32-mesa lib32-libjpeg6-turbo lib32-libxmu

# Add your user to the boinc group
sudo usermod -a -G boinc $(whoami)
# Needs logout and login again
groups # Checks if you are in the group

# Start the boinc service
systemctl start boinc.service
systemctl status boinc.service
# systemctl restart boinc.service
# systemctl stop boinc.service

mkdir ~/workspace
mkdir ~/workspace/boinc
cd ~/workspace/boinc
ln -s /var/lib/boinc/gui_rpc_auth.cfg gui_rpc_auth.cfg
sudo chmod 640 gui_rpc_auth.cfg

boincmgr
# Add the projects
https://einsteinathome.org/
https://boinc.bakerlab.org/rosetta/


# Computer 12543238 has been merged successfully into 12467511.
 



boinccmd --lookup_account URL email passwd

# Resources
# https://boinc.berkeley.edu/wiki/Stop_or_start_BOINC_daemon_after_boot
# https://www.mankier.com/1/boinccmd
# https://boinc.berkeley.edu/wiki/Boinccmd_tool



# Add keyword events
echo -e '#!/bin/sh\namixer -q sset Master 5%+' | sudo tee /etc/acpi/events/volumeup > /dev/null
sudo chmod +x /etc/acpi/events/volumeup
echo -e '#!/bin/sh\namixer -q sset Master 5%-' | sudo tee /etc/acpi/events/volumedown > /dev/null
sudo chmod +x /etc/acpi/events/volumedown
echo -e '#!/bin/sh\namixer -q sset Master toggle' | sudo tee /etc/acpi/events/volumemute > /dev/null
sudo chmod +x /etc/acpi/events/volumemute
sudo acpid restart











# List of countries
reflector --list-countries

# Create Mirror List Server by speed and with the protocol https at least 10 servers
sudo reflector --country 'US' --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist


# Force pacman to refresh the package lists
sudo pacman -Syyu  --noconfirm




# https://wiki.archlinux.org/index.php/Xbindkeys
# touch ~/.xbindkeysrc
xbindkeys -d > ~/.xbindkeysrc

# Identifying keycodes
xbindkeys -k

# Reload the configuration file and apply the changes
xbindkeys -p
xbindkeys


##################################
# End of xbindkeys configuration #
##################################

# Increase volume
"amixer -q sset Master 5%+"
   XF86AudioRaiseVolume

# Decrease volume
"amixer -q sset Master 5%-"
   XF86AudioLowerVolume

# Mute/Unmute volumen
"amixer -q sset Master toggle"
   XF86AudioMute



##################################
# Games
##################################

# Install a lot of libraries from this AUR package
yaourt -S wine-gaming-nine


# Steam
# --------------------------------
# https://wiki.archlinux.org/index.php/Steam
# https://wiki.archlinux.org/index.php/Steam/Troubleshooting
# https://wiki.archlinux.org/index.php/Steam/Game-specific_troubleshooting
# https://wiki.archlinux.org/index.php/Gamepad

# Install Steam

# Easy way
# --------------------------------
yaourt -S  steam-native-runtime

# Install OpenSSL 1.0
yaourt -S lib32-libopenssl-1.0-compat
# If some game not work, try that first
# To set custom launch options for a game, right-click on it in your library, select Properties and click on the Set Launch Options button.
# Add to your launch options:
# LD_LIBRARY_PATH="/usr/lib:$LD_LIBRARY_PATH"
# LD_LIBRARY_PATH=/usr/lib/openssl-1.0-compat

# Play with any USB controller on Linux using Steam Big Picture
# http://steamcommunity.com/app/221410/discussions/0/558748822569010381/

# Play with any USB controller on Linux using xboxdrv to emulate a XBOX controller 
# https://steamcommunity.com/app/221410/discussions/0/558748653738497361/


# Custome way

# https://wiki.archlinux.org/index.php/Steam
sudo geany /etc/pacman.conf
# Avoid the hashtags
[multilib]
Include = /etc/pacman.d/mirrorlist

sudo pacman -S steam

# Steam/Troubleshooting
#https://wiki.archlinux.org/index.php/Steam/Troubleshooting#Steam_runtime_issues

# Install steam without UI, then if you run steam-native it show the missing libraries
steam -textclient

# Run steam, if you got this errors
# libGL error: No matching fbConfigs or visuals found
# libGL error: failed to load driver: swrast
sudo pacman -S lib32-nvidia-utils


# Missing libraries
# ----------------------------------------------------------------------
cd ~/.local/share/Steam/ubuntu12_32
file * | grep ELF | cut -d: -f1 | LD_LIBRARY_PATH=. xargs ldd | grep 'not found' | sort | uniq

# All this libraries should be there in MultiLib repositories

# libXtst.so.6 => not found
sudo pacman -S lib32-libxtst

# libgio-2.0.so.0 => not found
# libglib-2.0.so.0 => not found
# libgobject-2.0.so.0 => not found
sudo pacman -S lib32-libdbusmenu-glib

# libfontconfig.so.1 => not found
# libfreetype.so.6 => not found
sudo pacman -S lib32-fontconfig

# libgdk_pixbuf-2.0.so.0 => not found
sudo pacman -S lib32-gdk-pixbuf2

# libopenal.so.1 => not found
sudo pacman -S lib32-openal

# libXrandr.so.2 => not found
sudo pacman -S lib32-libxrandr

# libXinerama.so.1 => not found
sudo pacman -S lib32-libxinerama

# libusb-1.0.so.0 => not found
sudo pacman -S lib32-libusb

# libudev.so.0 => not found
sudo pacman -S lib32-libudev0-shim

# libICE.so.6 => not found
# libSM.so.6 => not found
sudo pacman -S lib32-libsm

# libpulse.so.0 => not found
sudo pacman -S lib32-libpulse

# libdbus-glib-1.so.2 => not found
# libnm-glib.so.4 => not found
# libnm-util.so.2 => not found
sudo pacman -S lib32-libnm-glib

# libgtk-x11-2.0.so.0 => not found
sudo pacman -S lib32-gtk2

# Others
sudo pacman -S lib32-libxft
sudo pacman -S lib32-freetype2
sudo pacman -S lib32-libpng12 




# Errors and warnings
# https://wiki.archlinux.org/index.php/Steam/Troubleshooting#Configure_PulseAudio
# ----------------------------------------------------------------------
# Solved with the correct configuration in ~/.asoundrc


# Other errors
# ----------------------------------------------------------------------
# ERROR: ld.so: object '~/.local/share/Steam/ubuntu12_64/gameoverlayrenderer.so' from LD_PRELOAD cannot be preloaded (wrong ELF class: ELFCLASS64): ignored.

# This can be fixed, however, by forcing the game to use a later version of OpenGL than it wants. Right click on the game, select Properties. Then, click "Set Launch Options" in the "General" tab and paste the following: 
# MESA_GL_VERSION_OVERRIDE=3.1 MESA_GLSL_VERSION_OVERRIDE=140 %command%

# Setup with multiple monitors can cause error which will make game unable to start. If you stuck on this error and have multiple monitors, try to disable all additional displays, and then run a game. You can enable them after the game successfully started. 
export LD_LIBRARY_PATH=/usr/lib32/nvidia:/usr/lib/nvidia:$LD_LIBRARY_PATH



# Play with any USB controller on Linux using xboxdrv to emulate a XBOX controller 
# https://steamcommunity.com/app/221410/discussions/0/558748653738497361/
# ----------------------------------------------------------------------
# Install xboxdrv
# https://aur.archlinux.org/packages/xboxdrv/
git clone https://aur.archlinux.org/xboxdrv.git
cd xboxdrv
sudo pacman -S python2-dbus
sudo pacman -S scons
sudo pacman -S boost
makepkg --check
makepkg -si

# It should be return nothing
lsmod | grep xpad

# List all your available input events,
sudo pacman -S evtest
ls /dev/input/ | grep event*
# Try every one from 0 to 20 and press some button in the controller if in the terminal print lines every you press that's the event.
# PS2 normally is the even 11
# PS3 normally is the even 13
sudo evtest /dev/input/event13

# Initializing xboxdrv
sudo xboxdrv --detach-kernel-driver --mimic-xpad
xboxdrv --silent --detach-kernel-driver

# Install Joy2Key
yaourt -S joy2key




# Steam Games
# ----------------------------------------------------------------------

# Payday 2
# Game does not start
# http://steamcommunity.com/app/218620/discussions/22/350544272215417292/

# https://aur.archlinux.org/packages/blt4l-runtime-bin/
# https://github.com/blt4linux/blt4l
yaourt -S blt4l-runtime-bin

# No audio
pacman -Qs pulseaudio
pacman -Si pulseaudio
sudo pacman -S pulseaudio
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



# Amnesia: The Dark Descent
# Tricks and Hacks
cd ~/.frictionalgames/Amnesia/Main/[userNameInTheGame]
# Then ls and you see all your save files, open the last one and modify
# <var type="2" name="mlTinderboxes" val="999" />	Unlimited Tinderboxes
# <var type="3" name="mfHealth" val="9999.000000" />	Unlimited Health
# <var type="3" name="mfLampOil" val="9999.000000" />	Unlimited Oil
# <var type="3" name="mfSanity" val="9999.000000" />	Unlimited Sanity

# Walkthrough
# https://www.gamefaqs.com/pc/978772-amnesia-the-dark-descent/faqs/60874




# ----------------------------------------------------------------------
sudo geany /etc/pulse/client.conf





# Show the steam installed information
pacman -Qi steam

# List all installed packages that have the text "nvidia" mentioned somewhere
pacman -Qs nvidia

sudo pacman -S nvidia
sudo pacman -S nvidia-libgl
sudo pacman -S lib32-nvidia-libgl



# Remove Steam
sudo pacman -Rs steam
sudo pacman -Rsc steam


# FreedroidRPG — Mature science fiction role playing game set in the future
sudo pacman -S freedroidrpg

# OpenMW — Attempt to reimplement the popular role-playing game Morrowind. OpenMW aims to be a fully playable, open source implementation of the game's engin
sudo pacman -S openmw

# Cube 2: Sauerbraten — Improved version of the Cube engine.
sudo pacman -S sauerbraten

# Urban Terror — Modern multiplayer FPS based on the ioquake3 engine.
sudo pacman -S urbanterror

# Flight Gear — Open-source, multi-platform flight simulator.
sudo pacman -S flightgear

# Oolite — 3D space trading and combat simulator in the spirit of Elite.
sudo pacman -S oolite

# Globulation 2 — Multiplayer RTS with some "economic" elements minimizing the amount of micromanagement.
sudo pacman -S glob2

# The Battle for Wesnoth — Free, turn-based tactical strategy game with a high fantasy theme, featuring both single-player, and online/hotseat multiplayer combat.
sudo pacman -S wesnoth

# Simutrans — Another Transport simulation that works on linux with sdl.
sudo pacman -S simutrans

# OpenTTD — Open source clone of the Microprose game "Transport Tycoon Deluxe", a popular game originally written by Chris Sawyer. It attempts to mimic the original game as closely as possible while extending it with new features.
sudo pacman -S openttd

# Lincity-ng — City simulation game in which you are required to build and maintain a city. You can win the game either by building a sustainable economy or by evacuating all citizens with spaceships.
sudo pacman -S lincity-ng

# Dofus — Free, manga inspired, Massively Multiplayer Online Role-playing Game (MMORPG) for Adobe AIR
sudo pacman -S dofus #AUR

#      Savage 2: A Tortured Soul — Fantasy themed online multiplayer team-based FPS/RTS/RPG hybrid. Free-to-play as of December 2008. Pay for premium accounts providing crucial game elements such as extra inventory slots, access to clans and removal of the Hellbourne unit restrictions (per-account), as well as access to replays and stats.
sudo pacman -S savage2 #AUR

# Planeshift — Role Playing Game immersed into a 3D virtual fantasy world which is FULLY FREE to play. Fully free means you will have no surprises of premium content which will limit your gameplay or unbalance the game. There are no limitations in skills, ranks, abilities, items you can gain with your free account
sudo pacman -S planeshift #AUR

# RuneScape — Massive online adventure game by Jagex
sudo pacman -S runescape-launcher #AUR (new NXT client)

# Ryzom — 3D Fantasy MMORPG
sudo pacman -S ryzom-client #AUR








# Config audio en stereo mode for movies
# https://bbs.archlinux.org/viewtopic.php?id=167275
# Replace the file for that
geany ~/.asoundrc


defaults.pcm.rate_converter "samplerate_best"

pcm.snd_card {
        type hw
        card 0
}

pcm.aout {
        type dmix
        ipc_key 1
        ipc_key_add_uid false
        ipc_perm 0660
        slave {
                pcm "snd_card"
                channels 2
        }
}

# Audio in
pcm.ain {
        type dsnoop
        ipc_key 2
        ipc_key_add_uid false
        ipc_perm 0660
        slave {
                pcm "snd_card"
                channels 2
        }
}

pcm.!surround71 {
        type vdownmix
        slave.pcm "aout"
}

pcm.asymed {
        type asym
        playback.pcm "surround71"
        capture.pcm  "ain"
}

pcm.!default {
        type plug
        slave.pcm "asymed"
}
