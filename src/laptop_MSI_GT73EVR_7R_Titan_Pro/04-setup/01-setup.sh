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
echo -e ""
mkdir -p ~/.config
mkdir -p ~/workspace


# Installing the screen fetch for ASCII logo in Linux
echo -e "Installing the screen fetch for ASCII logo in Linux"
sudo pacman -S --needed --noconfirm screenfetch
echo -e "\n"


# Set up the config files into home folder.
echo -e "Setting up the config files into home folder."
curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git
cp ./setup-resources/.bash_profile ~/
# TODO: Change permissions to 644 for all this files.
cp ./setup-resources/.bashrc ~/
cp ./setup-resources/.toprc ~/
cp ./setup-resources/.Xresources ~/
cp ./setup-resources/.tmux.conf ~/
cp -R ./setup-resources/.config/openbox ~/.config/
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
echo -e ""
echo -e "Upgrading system"
echo -e ""
sudo pacman --noconfirm -Syyu
echo -e "\n"

# Uncomment #Color, if you want the pacman's output has colors
#Color
echo -e "Activing color option in pacman"
sudo sed -i '/Color$/ s/^##*//' /etc/pacman.conf
echo -e ""



# Reflector
# ----------------------------------------------------------------------
# Retrieves the latest mirrorlist from the MirrorStatus page, filters
# the most up-to-date mirrors, sorts them by speed and overwrites.
echo -e "Installing reflector"
echo -e ""
sudo pacman -S --needed --noconfirm reflector
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-bck-$(date +%Y-%m-%d)
echo -e "\n"

echo -e "Upgrading mirror list"
echo -e ""
sudo reflector --verbose --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
echo -e "\n"

echo -e "Upgrading system"
echo -e ""
sudo pacman --noconfirm -Syyu
echo -e "\n"

# Update Arch Linux automatically every day
echo -e "Setting up automate for daily system upgrade"
echo -e ""
upgradeSystemService=/etc/systemd/system/upgrade_system.service
sudo rm -f $upgradeSystemService
sudo touch $upgradeSystemService
sudo chmod 755 $upgradeSystemService
echo -e "[Unit]" | sudo tee -a $upgradeSystemService
echo -e "Description=Pacman upgrade the system\n" | sudo tee -a $upgradeSystemService
echo -e "[Service]" | sudo tee -a $upgradeSystemService
echo -e "Type=oneshot" | sudo tee -a $upgradeSystemService
echo -e "ExecStart=/usr/bin/pacman --noconfirm -Syyu" | sudo tee -a $upgradeSystemService

upgradeSystemTimer=/etc/systemd/system/upgrade_system.timer
sudo rm -f $upgradeSystemTimer
sudo touch $upgradeSystemTimer
sudo chmod 755 $upgradeSystemTimer
echo -e "[Unit]" | sudo tee -a $upgradeSystemTimer
echo -e "Description=Run pacman system upgrade daily" | sudo tee -a $upgradeSystemTimer
echo -e "Requires=network-online.target" | sudo tee -a $upgradeSystemTimer
echo -e "After=network-online.target\n" | sudo tee -a $upgradeSystemTimer
echo -e "[Timer]" | sudo tee -a $upgradeSystemTimer
echo -e "OnCalendar=daily" | sudo tee -a $upgradeSystemTimer
echo -e "RandomizedDelaySec=12h" | sudo tee -a $upgradeSystemTimer
echo -e "Persistent=true\n" | sudo tee -a $upgradeSystemTimer
echo -e "[Install]" | sudo tee -a $upgradeSystemTimer
echo -e "WantedBy=timers.target" | sudo tee -a $upgradeSystemTimer
echo -e "\n"

sudo systemctl enable upgrade_system.timer


# Update the servers links for packages automatically every day
echo -e "Setting up automate for daily reflector updates"
echo -e ""
reflectorService=/etc/systemd/system/reflector.service
sudo rm -f $reflectorService
sudo touch $reflectorService
sudo chmod 755 $reflectorService
echo -e "[Unit]" | sudo tee -a $reflectorService
echo -e "Description=Pacman mirrorlist update with reflector\n" | sudo tee -a $reflectorService
echo -e "[Service]" | sudo tee -a $reflectorService
echo -e "Type=oneshot" | sudo tee -a $reflectorService
echo -e "ExecStart=/usr/bin/reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist" | sudo tee -a $reflectorService

reflectorTimer=/etc/systemd/system/reflector.timer
sudo rm -f $reflectorTimer
sudo touch $reflectorTimer
sudo chmod 755 $reflectorTimer
echo -e "[Unit]" | sudo tee -a $reflectorTimer
echo -e "Description=Run reflector minutely" | sudo tee -a $reflectorTimer
echo -e "Requires=network-online.target" | sudo tee -a $reflectorTimer
echo -e "After=network-online.target\n" | sudo tee -a $reflectorTimer
echo -e "[Timer]" | sudo tee -a $reflectorTimer
echo -e "OnCalendar=hourly" | sudo tee -a $reflectorTimer
echo -e "RandomizedDelaySec=5min" | sudo tee -a $reflectorTimer
echo -e "Persistent=true\n" | sudo tee -a $reflectorTimer
echo -e "[Install]" | sudo tee -a $reflectorTimer
echo -e "WantedBy=timers.target" | sudo tee -a $reflectorTimer
echo -e "\n"

sudo systemctl enable reflector.timer




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

# Useful commands
#speaker-test -c2 -twav -l1
#aplay -L
#aplay --list-devices
#amixer controls | grep Master
#cat /sys/class/sound/card*/id
#cat /proc/asound/card0/pcm0p/info
#cat /proc/asound/card0/pcm3p/info


# Pulse audio
echo -e "Installing Pulse audio"
sudo pacman -S --needed --noconfirm pulseaudio
echo -e "\n"


# Bash completion
echo -e "Installing Bash completion"
sudo pacman -S --needed --noconfirm bash-completion
echo -e "\n"

echo -e "Installing upower"
echo -e ""
sudo pacman -S --needed --noconfirm upower #Show information about your laptop battery
echo -e "\n"


echo -e "Ready! The next step is run './02-xorg.sh'."
# TODO: Same as reboot add the press any key to logout from your seassion and force to re login.
echo -e "For best results please log out from your session and log in again: `exit`.\n"

echo -e "Finished successfully!"
echo -e ""
