#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Intro
# ----------------------------------------------------------------------
# Looks this documentation for more information about the specific setup

# Installation guide
# https://wiki.archlinux.org/index.php/Installation_guide

# Laptop main page contains links to article.
# https://wiki.archlinux.org/index.php/Laptop

# List of applications
# https://wiki.archlinux.org/index.php/List_of_applications

# Codecs
# https://wiki.archlinux.org/index.php/Codecs

# Openbox: window manager
# http://openbox.org/wiki/Help:Getting_started


# ----------------------------------------------------------------------
# Init
# ----------------------------------------------------------------------
# This is the basic setup


# General setup for this script and the following
# ----------------------------------------------------------------------
funcIsConnectedToInternet

# Create a temp directory for the next scripts
mkdir -p ~/.config
mkdir -p ~/workspace


# Installing the screen fetch for ASCII logo in Linux
echo -e "Installing the screen fetch for ASCII logo in Linux"
sudo pacman -S --needed --noconfirm screenfetch
echo -e "\n"


# Set up the config files into home folder.
echo -e "Setting up the config files into home folder."
curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git
# TODO: Change permissions to 644 for all this files.
cp -R ./setup-resources/.[^.]* ~/
sed -i -- 's/wolf/'${yourUserName}'/g' ~/.xinitrc
echo -e "\n"

# Pacman config
# ----------------------------------------------------------------------
# sudo nano /etc/pacman.conf

# Multilib
# Run and build 32-bit applications on 64-bit installations of Arch Linux.
# https://wiki.archlinux.org/index.php/Multilib

# Uncomment these both lines:
# [multilib]
# Include = /etc/pacman.d/mirrorlist
# This command delete the comments:
echo -e "Activing MultiLib"
sudo sed -i '/\[multilib\]/,/mirrorlist/ s/^##*//' /etc/pacman.conf
echo -e "Upgrading system"
sudo pacman --noconfirm -Syyu
echo -e "\n"

# Uncomment #Color, if you want the pacman's output has colors
#Color
echo -e "Activing color option in pacman"
sudo sed -i '/Color$/ s/^##*//' /etc/pacman.conf



# Reflector
# ----------------------------------------------------------------------
# Retrieves the latest mirrorlist from the MirrorStatus page, filters
# the most up-to-date mirrors, sorts them by speed and overwrites.
echo -e "Installing reflector"
sudo pacman -S --needed --noconfirm reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-bck-$(date +%Y-%m-%d)
echo -e "\n"

echo -e "Upgrading mirror list"
sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
echo -e "\n"

echo -e "Upgrading system"
sudo pacman --noconfirm -Syyu
echo -e "\n"

# Update Arch Linux automatically every day
echo -e "Setting up automated job for daily system upgrade"
upgrade_system_service=/etc/systemd/system/upgrade_system.service

echo -e \
'[Unit]
Description=Pacman upgrading the system

[Service]
Type=oneshot
ExecStart=/usr/bin/pacman --noconfirm -Syyu' | sudo tee ${upgrade_system_service}

sudo chmod 755 ${upgrade_system_service}


upgrade_system_timer=/etc/systemd/system/upgrade_system.timer

echo -e \
'[Unit]
Description=Run pacman upgrade system every 5 minutes
Requires=network-online.target
After=network-online.target

[Timer]
OnCalendar=hourly
RandomizedDelaySec=30min
Persistent=true

[Install]
WantedBy=timers.target' | sudo tee ${upgrade_system_timer}

sudo chmod 755 ${upgrade_system_timer}

echo -e "\n"

sudo systemctl enable ${upgrade_system_timer}


# Update the servers links for packages automatically every 5 minutes
echo -e "Setting up automated job for update servers with reflector every 5 minutes"
reflector_service=/etc/systemd/system/reflector.service

echo -e \
'[Unit]
Description=Pacman mirrorlist updated with reflector

[Service]
Type=oneshot
ExecStart=/usr/bin/reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist' | sudo tee ${reflector_service}

sudo chmod 755 ${reflector_service}


reflector_timer=/etc/systemd/system/reflector.timer

echo -e \
'[Unit]
Description=Run reflector every 5 minutes
Requires=network-online.target
After=network-online.target

[Timer]
OnCalendar=hourly
RandomizedDelaySec=5min
Persistent=true

[Install]
WantedBy=timers.target' | sudo tee ${reflector_timer}

sudo chmod 755 ${reflector_timer}

echo -e "\n"

sudo systemctl enable ${reflector_timer}




# Yaourt
# ----------------------------------------------------------------------

# Install yaourt: a pacman frontend which install the AUR packages.
echo -e "Installing git"
sudo pacman -S --needed --noconfirm git
echo -e "\n"

echo -e "Installing package-query"
funcInstallAur package-query
echo -e "\n"

echo -e "Installing yaourt"
funcInstallAur yaourt
echo -e "\n"


# Audio Alsa
#-----------------------------------------------------------------------
# https://wiki.gentoo.org/wiki/ALSA
echo -e "Installing Alsa utils"
sudo pacman -S --needed --noconfirm alsa-utils
echo -e "\n"

echo -e "Adding audio into the user group"
sudo usermod -a -G audio $(whoami)
echo -e "\n"


# Pulse audio
echo -e "Installing Pulse audio"
sudo pacman -S --needed --noconfirm pulseaudio
echo -e "\n"

# TODO: Uncomment these lines if the woofer is not working in the next instllation form scratch.

#~ echo -e "Configure pulseaudio to recognize the woofer"

#~ ehco -e "Configuring the daemon.conf file"
#~ cp /etc/pulse/daemon.conf ~/.config/pulse/
#~ sed -i '/; enable-lfe-remixing = no/ s/^;;* *//' ~/.config/pulse/daemon.conf
#~ sed -i 's/enable-lfe-remixing = no/enable-lfe-remixing = yes/g' ~/.config/pulse/daemon.conf

#~ ehco -e "Configuring the default.pa file"
#~ cp /etc/pulse/default.pa ~/.config/pulse/
#~ sed -i "\$a\\\n\nload-module module-combine channels=6 channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe" ~/.config/pulse/default.pa
#~ echo -e "\n"

# Try to test the woofer
#speaker-test -c6 -s6 -twav
# http://www.leeenux-linux.com/blog/woofer-and-subwoofer-test/
# http://www.leeenux-linux.com/WooferTest/120-129.mp3

# Useful commands
#speaker-test -c2 -twav -l1
#speaker-test -c6 -twav -l1
#aplay --list-devices
#aplay -L
#amixer controls | grep Master
#cat /sys/class/sound/card*/id
#cat /proc/asound/card0/pcm0p/info
#cat /proc/asound/card0/pcm3p/info


# Bash completion
#-----------------------------------------------------------------------
echo -e "Installing Bash completion"
sudo pacman -S --needed --noconfirm bash-completion
echo -e "\n"

echo -e "Installing upower"
sudo pacman -S --needed --noconfirm upower #Show information about your laptop battery
echo -e "\n"


echo -e "Ready! The next step is run './02-xorg.sh'."
# TODO: Same as reboot add the press any key to logout from your seassion and force to re login.
echo -e "For best results please log out from your session and log in again: `exit`.\n"

echo -e "Finished successfully!"
echo -e ""
