# Arch Linux: Installer and setup

Arch Linux is a great distro but I spend a lot of time installing and setting up with my preferences then here are some scripts for execute all of this stuff or understand how the Arch Linux works.

---

## Steps
### 1. Create your bootloader USB to boot with Arch Linux
Download the Arch Linux image.

http://mirror.rackspace.com/archlinux/iso/latest/arch/boot/intel_ucode.img
http://mirror.rackspace.com/archlinux/iso/latest/arch/boot/x86_64/archiso.img

Setup your USB and load the image.

[https://wiki.archlinux.org/index.php/USB_flash_installation_media](https://wiki.archlinux.org/index.php/USB_flash_installation_media){:target="_blank"}



### 2. Init
Reboot your computer with your bootloader USB and start with the USB.

Select the fist option which is ????????.

Wait for the login session, if it requiered a user you can press [enter] or write root.

The first thing you should to do is download the "init script" to start this journey.
```bash
mkdir -p ~/workspace
cd ~/workspace
curl -LOk https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/01-init/01-init.sh
chmod +x 01-init.sh
./01-init.sh
rm -f 01-init.sh
chmod +x ./archLinux-installer-and-setup-master/*.sh
```

This script create a directory which name is "archLinux-installer-and-setup-master", this directory contains all the scripts to install and setup your Arch Linux.
