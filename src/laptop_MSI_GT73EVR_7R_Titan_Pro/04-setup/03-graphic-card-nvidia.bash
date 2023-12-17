#!/usr/bin/env bash
set -ve

# ----------------------------------------------------------------------
# Arch Linux :: Setup - NVIDIA step 1 / 3
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

source ./../00-configuration.bash

funcIsConnectedToInternet

# -------------------------- #
# SET UP NVIDIA GRAPHIC CARD #
# -------------------------- #

# ------------------- #
# Set up the generals #
# ------------------- #

# Check the installed graphic cards in your computer.
lspci -k | grep -A 2 -E "(VGA|3D)"

# Install the NVIDIA drivers for linux.
# Install the NVIDIA drivers utilities.
# Install the NVIDIA drivers utilities (32-bit).
# Install the NVIDIA's GPU programming toolkit.
sudo pacman --sync --needed --noconfirm \
  nvidia nvidia-utils lib32-nvidia-utils cuda nvidia-settings opencl-nvidia lib32-opencl-nvidia \
  opencl-headers opencl-clhpp glu

# TODO: Check if I need this package.
# Install OpenCL ICD Bindings.
#sudo pacman --sync --needed --noconfirm ocl-icd

# TODO: Check if I need this package.
# Install OpenCL Info.
#sudo pacman --sync --needed --noconfirm clinfo

# Run NVIDIA X-configuration.
sudo nvidia-xconfig

# Comment the Nvidia value for is primary GPU
# https://superuser.com/questions/1590416/how-to-get-x-to-ignore-my-primary-gpu
sudo sed --in-place '/Option "PrimaryGPU"/ s/^#*/#/' /usr/share/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf

# ----------- #
# Pacman Hook #
# ----------- #

# Create directory.
sudo mkdir --parents /etc/pacman.d/hooks

# Add trigger for pacman.
echo "
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=usr/lib/modules/*/vmlinuz

[Action]
Description=Update NVIDIA module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case \$trg in linux*) exit 0; esac; done; /usr/bin/mkinitcpio -P'
" | sudo tee /etc/pacman.d/hooks/nvidia.hook

# -------------- #
# Kernel modules #
# -------------- #

# Add parameters to the kernel.
echo "
# NVIDIA kernel parameters.
options nouveau modeset=0
options nvidia_drm modeset=1
" | sudo tee /etc/modprobe.d/nvidia.conf

# ----------------- #
# Kernel parameters #
# ----------------- #

# Duplicate the default command line and add NVIDIA.
sudo sed --in-place '/^GRUB_CMDLINE_LINUX_DEFAULT=/p' /etc/default/grub
sudo sed --in-place '0,/^GRUB_CMDLINE_LINUX_DEFAULT=/ s//#&/' /etc/default/grub
sudo sed --in-place 's/^GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet nouveau.modeset=0 nvidia_drm.modeset=1"/' /etc/default/grub

# Build GRUB.
sudo grub-mkconfig -o /boot/grub/grub.cfg

# ---------------------- #
# Change initial ramdisk #
# ---------------------- #

# Set the module decompress to yes.
sudo sed --in-place '/MODULES_DECOMPRESS="yes"/ s/^#//' /etc/mkinitcpio.conf

# Set to cat the compression of the initramfs image.
sudo sed --in-place 's/#COMPRESSION="lz4"/&\nCOMPRESSION="cat"/#/' /etc/mkinitcpio.conf

# Duplicate the hooks and remove the KMS.
sudo sed --in-place '/^HOOKS=/p' /etc/mkinitcpio.conf
sudo sed --in-place '0,/^HOOKS=/ s//#&/' /etc/mkinitcpio.conf
sudo sed --in-place '/^HOOKS=/ s/\s*kms\s*/ /' /etc/mkinitcpio.conf

# Duplicate the hooks and remove the KMS.
sudo sed --in-place '/^MODULES=/p' /etc/mkinitcpio.conf
sudo sed --in-place '0,/^MODULES=/ s//#&/' /etc/mkinitcpio.conf
sudo sed --in-place 's/^MODULES=()/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf

# Create an initial ramdisk environment.
sudo mkinitcpio --preset linux

# -------- #
# Finished #
# -------- #

# The next step is set up basic packages in GUI Desktop.
# Execute './04-basic-gui.bash'.

# Reboot
read -n 1 -s -r -p "Press any key to reboot."

sudo reboot

# Avoid errors in the log
# ----------------------------------------------------------------------

# Needs to solve
#~ [ 161.208] (WW) Falling back to old probe method for modesetting
#~ [ 161.599] (WW) NVIDIA(0): Unable to get display device for DPI computation.
#~ [ 161.657] (WW) NVIDIA(0): Option "PrimaryGPU" is not used

# (WW) NVIDIA(0): Unable to get display device for DPI computation
# NVIDIA(0): DPI set to (75, 75); computed from built-in default
#sudo nvidia-xconfig

# If you are on a laptop, it might be a good idea to install and enable the acpid daemon instead.
# https://wiki.archlinux.org/index.php/NVIDIA/Tips_and_tricks#Manual_configuration
# https://wiki.archlinux.org/index.php/Acpid
#sudo pacman --sync --needed acpid
#systemctl start acpid.service

# (WW) The directory "/usr/share/fonts/Type1/" does not exist.
#sudo pacman --sync --needed xorg-fonts-type1
# (WW) The directory "/usr/share/fonts/OTF/" does not exist.
#sudo pacman --sync --needed --noconfirm xorg-fonts-misc

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
# First family to support using four monitors simultaneously on one GPU, older generations had only 2 CRTCs.
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
# - For GeForce 400-series cards and newer [NVCx and newer], install the nvidia or nvidia-lts package. If these packages do not work, nvidia-betaAUR may have a newer driver version that offers support.
# https://www.archlinux.org/packages/extra/x86_64/nvidia/
# https://www.archlinux.org/packages/extra/x86_64/nvidia-lts/
# https://aur.archlinux.org/packages/nvidia-beta/

# NOTE:
# In my personal opinion, I should install the nvidia-beta because we have more options,
# checks "Required by (15)" section, for example,
# - ffmpeg-nvenc.
# Complete solution to record, convert and stream audio and video with Nvidia CUDA Hardware Acceleration
# - cpyrit-cuda: Pyrit support for Nvidia-CUDA.
# - hoomd-blue: A general-purpose particle simulation toolkit using GPUs with CUDA.

# 3. Set up nvidia-xinitrc
# ---------------------------------------------------
# Before set this values you need to get the number of dpis for your
# display. There is some explanation in the next step.
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
# LVDS-1-1 connected 1366x768+0+0 (normal left inverted right x-axis y-axis) 309mm x 173mm

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

# Check the output.
# IMPORTANT: At this point, you wouldn't see any changes.
#xdpyinfo | grep -B2 resolution
# screen #0:
#  dimensions:    1366x768 pixels (309x174 millimeters)
#  resolution:    112x112 dots per inch
