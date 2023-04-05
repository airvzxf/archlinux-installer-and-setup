#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Nvidia graphic card
# ----------------------------------------------------------------------
# When upgrade pacman some time we lost the nvidia drivers we need to
# re-install that.
funcIsConnectedToInternet

echo -e ""

# Check what graphic cards have in your computer
echo -e "Checking the installed graphic card"
echo -e ""
lspci -k | grep -A 2 -E "(VGA|3D)"
echo -e "\n"

# Install basic packages
echo -e "Installing Linux headers"
echo -e ""
sudo pacman -S --needed --noconfirm linux-headers
echo -e "\n"

echo -e "Installing Xorg xrandr"
echo -e ""
sudo pacman -S --needed --noconfirm xorg-xrandr
echo -e "\n"

echo -e "Installing Xorg xdisplay info"
echo -e ""
sudo pacman -S --needed --noconfirm xorg-xdpyinfo
echo -e "\n"

echo -e "Installing Xorg fonts type 1"
echo -e ""
sudo pacman -S --needed --noconfirm xorg-fonts-type1
sudo pacman -S --needed --noconfirm xorg-fonts-misc
echo -e "\n"

echo -e "Installing bbSwitch"
echo -e ""
sudo pacman -S --needed --noconfirm bbswitch
echo -e "\n"


# Install nvidia packages
echo -e "Installing Nvidia utils"
echo -e ""
sudo pacman -S --needed --noconfirm nvidia-utils
echo -e "\n"

echo -e "Installing Nvidia"
echo -e ""
sudo pacman -S --needed --noconfirm nvidia
echo -e "\n"

echo -e "Installing Nvidia settings"
echo -e ""
sudo pacman -S --needed --noconfirm nvidia-settings
echo -e "\n"

echo -e "Installing Nvidia OpenCL"
echo -e ""
sudo pacman -S --needed --noconfirm opencl-nvidia
echo -e "\n"

echo -e "Installing OpenCL ICD Bindings"
echo -e ""
sudo pacman -S --needed --noconfirm ocl-icd
echo -e "\n"

echo -e "Installing OpenCL Info"
echo -e ""
sudo pacman -S --needed --noconfirm clinfo
echo -e "\n"

echo -e "Installing Cuda"
echo -e ""
sudo pacman -S --needed --noconfirm cuda
echo -e "\n"

#echo -e "Installing Nvidia xrun"
#echo -e ""
#yay -S --needed --noconfirm nvidia-xrun
#echo -e "\n"


# Install the windows manager
echo -e "Installing Openbox"
echo -e ""
sudo pacman --needed --noconfirm -S openbox
echo -e "\n"

echo -e "Installing AcpID"
echo -e ""
sudo pacman --needed --noconfirm -S acpid
echo -e "\n"

echo -e "Installing redshift"
# Automatically adjusts the color temperature of your screen avoiding the blue light.
echo -e ""
sudo pacman -S --needed --noconfirm redshift
echo -e "\n"


# Tmux: A terminal multiplexer
echo -e "Installing Tmux terminal multiplexer"
sudo pacman -S --needed --noconfirm tmux
echo -e "\n"


# Battery discharging beep
echo -e "Installing a Battery Discharging Deep"
yay -S --needed --noconfirm battery-discharging-beep-git
echo -e "\n"


# Turn on the numlock
#-----------------------------------------------------------------------
echo -e "Installing numlock which turns on the numlock key in X11"
sudo pacman -S --needed --noconfirm numlockx
echo -e "\n"


# Backlighting manager for MSI steelseries keyboards
#-----------------------------------------------------------------------
echo -e "Installing a backlighting manager for MSI steelseries keyboards"
yay -S --needed --noconfirm msiklm-git
echo -e "\n"


# Install xterm before run openbox window manager
echo -e "Installing xterm before run openbox window manager"
echo -e ""
sudo pacman -S --needed --noconfirm xterm # Terminal / Console window
echo -e "\n"


# Install Locate
echo -e "Installing locate"
echo -e ""
sudo pacman -S --needed --noconfirm plocate
echo -e "\n"


# Install ZSH
echo -e "Installing ZSH"
echo -e ""
sudo pacman -S --needed --noconfirm zsh lsd bat
sudo pacman -S --needed --noconfirm zsh-syntax-highlighting zsh-autosuggestions zsh-theme-powerlevel10k
yay -S --needed --noconfirm nerd-fonts-hack nerd-fonts-meslo
#yay -S --needed --noconfirm nerd-fonts-complete
cp ./setup-resources/.zshrc ~/
cp ./setup-resources/.p10k.zsh ~/
sudo usermod --shell /usr/bin/zsh
sudo ln -s -f ~/.zshrc /root/.zshrc
sudo ln -s -f ~/.p10k.zsh /root/.p10k.zsh
sudo usermod --shell /usr/bin/zsh root
echo -e "\n"


# Install Black Arch repository
echo -e "Installing Black Arch repository"
curl -L https://blackarch.org/strap.sh > ~/blackarch-repo.sh
chmod a+x ~/blackarch-repo.sh
sudo ~/blackarch-repo.sh
rm -f ~/blackarch-repo.sh
sudo pacman -Syy
echo -e "\n"


# Install kitty and fonts before run openbox window manager
echo -e "Installing kitty and fonts before run openbox window manager"
echo -e ""
sudo pacman -S --needed --noconfirm kitty # Terminal emulator
cp -p ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.bck.conf
sudo pacman -S --needed --noconfirm noto-fonts-emoji # Fonts with emojis
echo -e "\n"


echo -e "Run nvidia xconfig"
sudo nvidia-xconfig
echo -e "\n"


# TODO: Check if this config file is necessary.
#~ echo -e "Xorg with Nvidia"
#~ nvidia_config_file=/etc/X11/xorg.conf.d/20-nvidia.conf

#~ echo -e \
#~ 'Section "Device"
    #~ Identifier     "Nvidia Graphic Card"
    #~ Driver         "nvidia"
    #~ VendorName     "NVIDIA Corporation"
    #~ BoardName      "GeForce GTX 1080 Mobile"
    #~ BusID          "PCI:1:0:0"
#~ EndSection' | sudo tee ${nvidia_config_file}
#~ echo -e ""


# Xbindkeys
# https://wiki.archlinux.org/index.php/Xbindkeys
echo -e "Installing Xbind keys"
echo -e ""
sudo pacman -S --needed --noconfirm xbindkeys
echo -e "\n"

echo -e "Setting up the Xbind keys"
echo -e \
'# Increase volume
"pactl set-sink-volume 0 +1000"
   XF86AudioRaiseVolume

# Decrease volume
"pactl set-sink-volume 0 -1000"
   XF86AudioLowerVolume

# Mute
"amixer set Master toggle"
   XF86AudioMute

# Increase brightness
"xbacklight -5"
   XF86MonBrightnessDown

# Decrease brightness
"xbacklight +5"
   XF86MonBrightnessUp' | tee ~/.xbindkeysrc

# Refresh the bind keys
xbindkeys -p
echo -e ""


# Comment the Nvidia value for is primary GPU
echo -e "Comment the Nvidia value for is primary GPU"
sudo sed -i '/Option "PrimaryGPU"/ s/^#*/#/' /usr/share/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
echo -e "\n"


echo -e "=== Solving Xorg warnings ==="
echo -e "mkfontdir in font dpis"
sudo mkfontdir /usr/share/fonts/100dpi/
sudo mkfontdir /usr/share/fonts/75dpi/
echo -e ""
echo -e "Enable ACPID service"
sudo systemctl enable --now acpid
echo -e ""



echo -e "Ready! The next step is run './03a02-graphic-card-nvidia-startx.sh'.\n"

# Reboot
read -n 1 -s -r -p "Press any key to reboot"
reboot




# Avoid errors in the log
# ----------------------------------------------------------------------

# Needs to solve
#~ [   161.208] (WW) Falling back to old probe method for modesetting
#~ [   161.599] (WW) NVIDIA(0): Unable to get display device for DPI computation.
#~ [   161.657] (WW) NVIDIA(0): Option "PrimaryGPU" is not used


# (WW) NVIDIA(0): Unable to get display device for DPI computation
# NVIDIA(0): DPI set to (75, 75); computed from built-in default
#sudo nvidia-xconfig

# If you are on laptop, it might be a good idea to install and enable the acpid daemon instead.
# https://wiki.archlinux.org/index.php/NVIDIA/Tips_and_tricks#Manual_configuration
# https://wiki.archlinux.org/index.php/Acpid
#sudo pacman -S --needed acpid
#systemctl start acpid.service

# (WW) The directory "/usr/share/fonts/Type1/" does not exist.
#sudo pacman -S --needed xorg-fonts-type1
# (WW) The directory "/usr/share/fonts/OTF/" does not exist.
#sudo pacman -S --needed --noconfirm xorg-fonts-misc

# Change the font type
# https://wiki.archlinux.org/index.php/Font_configuration
# http://news.softpedia.com/news/How-to-Add-Beautiful-Fonts-to-Any-Linux-Distribution-434835.shtml

# (WW) Open ACPI failed (/var/run/acpid.socket) (No such file or directory)
# https://bbs.archlinux.org/viewtopic.php?id=64039



# Detailed explanation about the Nvidia installation
# ----------------------------------------------------------------------
# https://wiki.archlinux.org/index.php/NVIDIA#Installation

# Check what graphic card do you have
#lspci -k | grep -A 2 -E "(VGA|3D)"
# 01:00.0 3D controller: NVIDIA Corporation GK107M [GeForce GT 740M] (rev a1)


# 1. Check if your card is new or old
# ---------------------------------------------------
# https://nouveau.freedesktop.org/wiki/CodeNames/

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
# Version:  375.39
# Release Date:     2017.2.14
# Operating System:     Linux 64-bit
# Language:     English (US)
# File Size:    73.68 MB

# More information
# ---------------------------------------------------
# https://en.wikipedia.org/wiki/GeForce_700_series

# Code name: GK107
# Launch: April 1, 2013
# Fab: 28
# BUS: PCIe 3.0 x16
# Core config: 384:32:16


# 2. Check your appropriate driver
# ---------------------------------------------------

# Install the appropriate driver for your card:
# - For GeForce 400 series cards and newer [NVCx and newer], install the nvidia or nvidia-lts package. If these packages do not work, nvidia-betaAUR may have a newer driver version that offers support.
# https://www.archlinux.org/packages/extra/x86_64/nvidia/
# https://www.archlinux.org/packages/extra/x86_64/nvidia-lts/
# https://aur.archlinux.org/packages/nvidia-beta/

# NOTE: In my personal opinion I should install the nvidia-beta because we have more options, checks "Required by (15)" section, for example:
# - ffmpeg-nvenc. Complete solution to record, convert and stream audio and video with Nvidia CUDA Hardware Acceleration
# - cpyrit-cuda: Pyrit support for Nvidia-CUDA.
# - hoomd-blue: A general-purpose particle simulation toolkit using GPUs with CUDA.

# 3. Set up nvidia-xinitrc
# ---------------------------------------------------
# Before set this values you need to get the number of dpis for your
# display. There some explanation in the next step.
# Add this lines:
#xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112
#setxkbmap -model pc105 -layout latam -variant ,deadtilde
#openbox-session
# OR Execute this line
#echo -e "xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112\nsetxkbmap -model pc105 -layout latam -variant ,deadtilde\nopenbox-session\n" | sudo tee ~/.nvidia-xinitrc > /dev/null

# WARNING: libpng warning: iCCP: known incorrect sRGB profile
# https://wiki.archlinux.org/index.php/Libpng_errors
# convert -strip input_filename output_filename


# 4. Get DPIs
# ---------------------------------------------------
#xrandr | grep -w connected
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
#xrandr

# Create your xrandr configurations, right now you have all the information.
#xrandr --output LVDS-1-1 --mode 1366x768 --rate 60 --dpi 112

# Check the output. IMPORTANT: At this point you wouldn't see any changes.
#xdpyinfo | grep -B2 resolution
# screen #0:
#  dimensions:    1366x768 pixels (309x174 millimeters)
#  resolution:    112x112 dots per inch
