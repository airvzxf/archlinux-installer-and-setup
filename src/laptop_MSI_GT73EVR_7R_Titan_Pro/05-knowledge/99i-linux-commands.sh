#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Information
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Linux commands
# [DON'T EXECUTE THIS SCRIPT, IS ONLY INFORMATIVE]
# ----------------------------------------------------------------------

# Search the proccess in your system
ps aux | grep proccess_name
# PS do not show itself processor, put brackets in the first letter
ps aux | grep [p]roccess_name


# Add comments in lines between 2 and 4
sed -i '2,4 s/^/#/' test.conf
# Delete comments in lines between 1 and 2
sed -i '2,4 s/^##*//' test.conf
# Delete hastag comments between the match A to B
sed -i '/query_string_a/,/query_string_b/ s/^##*//' [filePath]
# Add comment at the star of this line if the string match
sed -i '/searching_string/ s/^#*/#/' [filePath]


# Search files or directories in this directory and sub directories
find ./ -iname *query_string*
# Search files or directories in all devices
sudo find / -iname *query_string* 2>/dev/null
# Serach only files
sudo find / -type f -iname *query_string* 2>/dev/null
# Serach only directories
sudo find / -type d -iname *query_string* 2>/dev/null

# Search files and do specific actions
find ./ -iname *query_string* -exec chmod +x {} \;
find ./ -type f -iname *query_string* -exec rm -f {} \;

# Search words inside of the files
grep -rnw [directory] -e [pattern]

# Show folder and files sizes
du -ahLHd 1 | sort -hr
du -hd 1 | sort -rh
du -h | sort -hr
du | sort -nr
# Show files too
du -ad 1 | sort -nr
# Only show the first directory
du -d 1 | sort -nr
# Dereference all symbolic links
du -LH -d 1 | sort -nr
# Show the total
du -s
#Count sizes many times if hard linked
du -l | sort -nr


# Open desktop files
gtk-launch [name].desktop

# Open files with the app in command line mode
xdg-open [file]

# Systemctl
# It's similar to Cron but new and improved
# https://wiki.archlinux.org/index.php/Systemd/Timers
# https://unix.stackexchange.com/questions/278564/cron-vs-systemd-timers
# https://jason.the-graham.com/2013/03/06/how-to-use-systemd-timers/
# Enable a unit to be started on bootup:
sudo systemctl enable [unit]
# Enable a unit to be started on bootup and Start immediately:
sudo systemctl enable --now [unit]

# Create a NTFS or FAT USB
# Delete / Create the partitions and use the FAT23 or NTFS
sudo cfdisk /dev/sdb
# Convert this partition to FAT format
sudo mkfs.vfat /dev/sdb1

# Mount and umount USB
sudo mkdir -p /mnt/usbstick
sudo mount -o gid=users,fmask=113,dmask=002 /dev/sdb1 /mnt/usbstick
sudo umount -R /mnt/usbstick

# Mount and umount USB, other way
grep $USER /etc/passwd
sudo mount -o uid=1000,gid=1000,utf8,fmask=137,dmask=027 /dev/sdb1 /mnt/usbstick/
sudo umount -R /mnt/usbstick

# Git
# Undo a "public" change
# https://stackoverflow.com/questions/1270514/undoing-a-git-push
git push -f origin last_known_good_commit:branch_name
# Missing certificate
# fatal: unable to access: error setting certificate verify locations:
#  CAfile: /etc/ssl/certs/ca-certificates.crt
sudo git config --system http.sslcainfo "/etc/ca-certificates/extracted/ca-bundle.trust.crt"

# Battery status
upower -i /org/freedesktop/UPower/devices/battery_BAT0
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|energy\:|time|percentage"

# Wifi menu
# Delete or modify a specific wifi
ls -lha /etc/netctl/
sudo rm -f /etc/netctl/[network-name]

# Enabling and disabling network interfaces
ip link
sudo ip link set down [interface]
sudo ip link set up [interface]
sudo killall dhcpcd
#sudo dhcpcd # Needs to reload the DHCP
sudo systemctl restart dhcpcd.service
# Show information about the IP
ip addr show dev [interface]
# If you connect a ethernet wire or USB/ethernet adaptor to refresh the
# DNS and enable your Internet connection run this command:
sudo killall dhcpcd
#sudo dhcpcd
sudo systemctl restart dhcpcd.service

# Reset the wifi connection
sudo ip link set down [interface]
sudo systemctl stop dhcpcd.service
sudo killall dhcpcd
sudo nscd
sudo nscd -K
sudo nscd -i hosts
ip addr flush dev [interface]
ip route flush dev [interface]
sudo ip link set up [interface]
sudo wifi-menu

# Print IP address version 4
ip -4 addr

# Network monitor in command line
vnstat --iflist # Show the devices
vnstat -i [device] -l # View live network traffic usage

# Network benchmark
# https://greyhound-forty.gitbooks.io/tech-support-notes/Topic03/Bandwidth_Speed.html

# Network performance measurement tool
nuttcp -i1 -r [IP]

# Testing two nodes
iperf -s -i 2 # Run in the host
iperf -c [IP] -t 20 -i 2 # Run in the node

# Speedtest in command line
speedtest-cli

# Utility to query the network driver and hardware settings
ethtool [device]

# Change user and load entire environment in shell script
sudo su [user] -c [command]
sudo su - [user] -c [command]
sudo su - [user]

# Check Hard Disk information
sudo hdparm -I /dev/sda

# Manage Systemd Services and Units
# https://www.tecmint.com/manage-services-using-systemd-and-systemctl-in-linux/
systemctl
systemctl list-unit-files
# List static, disabled or enable
systemctl list-unit-files --state=enabled
systemctl list-unit-files --state=disabled
# List running services
systemctl | grep running

# Debug the bash file
# In the bash scripts xxx.sh you are able to add 'set -x' to debug the script
#!/bin/bash
set -x # Enable debug output
set +x # Disable debug output

# Manage 2-monitors
# https://wiki.archlinux.org/index.php/xrandr#Manage_2-monitors
# https://wiki.archlinux.org/index.php/Multihead#RandR
# LVDS-1-1 is my laptop monitor
# HDMI left of LVDS at their preferred resolutions
xrandr --output HDMI-1-1 --mode 1920x1080i --set audio force-dvi --output LVDS-1-1 --mode 1366x768 --left-of HDMI-1-1 --dpi 140

# Turn off HDMI
xrandr --output HDMI-1-1 --off

# Restart all
xrandr --output HDMI-1-1 --off
xrandr --output LVDS-1-1 --off
xrandr --output LVDS-1-1 --primary --mode 1366x768 --rate 60 --dpi 112



# Connect bluetooth headset
# https://purplepalmdash.github.io/2013/12/19/bluetooth-headset-on-archlinux/
# https://wiki.archlinux.org/index.php/Bluetooth_headset#Headset_via_Bluez5.2FPulseAudio
sudo pacman -S --needed --noconfirm pulseaudio-alsa
sudo pacman -S --needed --noconfirm pulseaudio-bluetooth
sudo pacman -S --needed --noconfirm bluez
sudo pacman -S --needed --noconfirm bluez-libs
sudo pacman -S --needed --noconfirm bluez-utils

# This package not work properly in my laptop.
# yay -S bluez-utils-compat
# gpg --recv-keys 06CA9F5D1DCF2659


# How to check if you missing some module
lsmod > loaded-modules-before-sleep.txt
# Sleep your computer and wake up.
lsmod > loaded-modules-after-sleep.txt
diff loaded-modules-before-sleep.txt loaded-modules-after-sleep.txt


# Bluetooth problems when can't turn on the power or anothers
# https://unix.stackexchange.com/questions/113828/how-to-find-and-reload-specific-driver-from-kernel
lsmod | grep -i bluetooth
# bluetooth: 10 btrtl,btintel,bnep,btbcm,rfcomm,ath3k,btusb
sudo rmmod ath3k && sudo modprobe ath3k
sudo rmmod btusb && sudo modprobe btusb
# Sleep the computer.
sudo systemctl restart bluetooth
bluetoothctl
# Wait until the controller is loaded again.


# Run these the first time
# Make sure your device is not blocked
rfkill list
#sudo rfkill unblock all
modprobe btusb
systemctl start bluetooth.service
pulseaudio -k

# Turn on your headset device

# Set up the first time
bluetoothctl
# Enter the next commands
# $ power on
# $ agent on
# $ default-agent
# $ scan on
# It shows:
#    [NEW] Device 30:23:57:A2:71:59 BX950
# $ trust [MAC Address]
# $ pair [MAC Address]
# $ connect [MAC Address]
# $ scan off
# $ exit

# If you had setted up your device you only need these
modprobe btusb
sudo systemctl restart bluetooth.service
bluetoothctl
power on
agent on
default-agent
connect 45:DA:91:0D:14:69
exit

# If you have problems with the sound try to close pulseaudio and open again
# the close and open spotify or any media player
pulseaudio -k
pulseaudio --start



# Bose the volume is very low at maximum volume in Alsamixer.
pip install avrcp-volume
sudo -E avrcp-volume --install-service
systemctl --user start avrcp-volume.service
systemctl --user enable avrcp-volume.service
# Then open alsamixer and tap the PgUp key until the max,
# and keep tapping. It set the high volume in the speaker.
alsamixer

# How to see the volumen of the devices
pacmd list-sinks | grep -e "index:" -e "name:" -e "base volume:" -e "volume:"
VOLUME="+5%"
INDEX=$(pactl list short sinks | grep "bluez_sink" | awk '{ print $1 }' | head -n1)
echo "INDEX: ${INDEX}"
# Repeat this command to increase or decrease the volume.
# Needs to rebase the max volume to set the volume of the speaker or headset to 127.
pactl set-sink-volume "${INDEX}" "${VOLUME}"
pacmd list-sinks | grep -e "name:" -e "index:" -e "base volume:" -e "volume:"
# The volume is increasing not the base volume wich is the Alsamixer
# volume: front-left: 32768 /  50% / -18.06 dB,   front-right: 32768 /  50% / -18.06 dB balance 0.00
# base volume: 65536 / 100% / 0.00 dB



# Search commands in the the packages
pkgfile [package]


# Show the RAM hardware info
sudo dmidecode --type memory


# Security in liux
#-------------------------------------------------------------------------------

# lynis
sudo lynis audit system

# rkhunter
sudo pacman -S lsof
yay -S skdet
yay -S tripwire-git
yay -S net-tools-debian-ifconfig

sudo rkhunter --propupd
sudo rkhunter --check --skip-keypress

# arch-audit
arch-audit

# Clam AntiVirus Scanner
sudo freshclam

# Nmap
nmap




# Create ssh keys to access into remote server without password
#-------------------------------------------------------------------------------

# In your local machine

mkdir -p ssh_keys

ssh-keygen -t rsa -b 4096 -f ./ssh_keys/free_access

ssh-copy-id -i ./ssh_keys/free_access -i ./ssh_keys/free_access user@IP
# Enter the remote user password to upload the ssh id

ssh -i ./ssh_keys/free_access user@IP




# Install VirtualBox
#-------------------------------------------------------------------------------
sudo pacman -S virtualbox-host-modules-arch
sudo pacman -S virtualbox
yay -S virtualbox-ext-oracle

# VirtualBox recognize USB.
sudo vboxmanage internalcommands createrawvmdk -filename  ~/VirtualBoxVMs/usb.vmdk -rawdisk /dev/sdz
sudo usermod -a -G vboxusers $(whoami)
sudo usermod -a -G disk $(whoami)
# Reboot

virtualbox




# Recording desktop
#-------------------------------------------------------------------------------
# A feature-rich screen recorder that supports X11 and OpenGL.
sudo pacman -S simplescreenrecorder


# PDF Information and Encryption
# ------------------------------------------------------------------------------
exiftool -a -G1 file.pdf


# Convert Images to PDF. If you need to rotate the images use the option: -rotate -90
# ------------------------------------------------------------------------------

convert IMAGES*.png \
	-gravity center \
	-density 150 \
	-units PixelsPerInch \
	OUT.pdf


# Convert Images to PDF with other command.
# ------------------------------------------------------------------------------

# First clean the PNG alpha transparency.
convert \
	IMAGES*.png \
	-background white \
	-alpha remove \
	-alpha off \
	-set filename:new 'cleaned_%t' %[filename:new].png

# Then convert.
img2pdf \
	--pagesize A4 \
	--auto-orient \
	--border 1cm:1cm \
	-o OUT.pdf \
	cleaned_IMAGES*.png
