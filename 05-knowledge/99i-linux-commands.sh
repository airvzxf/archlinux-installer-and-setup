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
# Don't show ps it self processor, put brackets in the first letter
ps aux | grep [p]roccess_name


# Add comments in lines between 2 and 4
sed -i '2,4 s/^/#/' test.conf
# Delete comments in lines between 1 and 2
sed -i '2,4 s/^##*//' test.conf
# Delete hastag comments between the match A to B
sed -i '/query_string_a/,/query_string_b/ s/^##*//' [filePath]


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

# Systemctl
# It's similar to Cron but new and improved
# https://wiki.archlinux.org/index.php/Systemd/Timers
# https://unix.stackexchange.com/questions/278564/cron-vs-systemd-timers
# https://jason.the-graham.com/2013/03/06/how-to-use-systemd-timers/

# Mount and umount USB
sudo mkdir -p /mnt/usb
sudo mount -o gid=users,fmask=113,dmask=002 /dev/sdb1 /mnt/usb
sudo umount -R /mnt/usb

# Git
# Undo a "public" change
# https://stackoverflow.com/questions/1270514/undoing-a-git-push
git push -f origin last_known_good_commit:branch_name

# Battery status
upower -i /org/freedesktop/UPower/devices/battery_BAT0
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|to\ full|time|percentage"
