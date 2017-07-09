# Arch Linux: Installer and setup

Arch Linux is a great distro but I spend a lot of time installing and setting up with my preferences then here are some scripts for execute all of this stuff or understand how the Arch Linux works.

---

## Steps
### 1. Create your bootloader USB to boot with Arch Linux

Download the Arch Linux image.<br>
[Image x86](http://mirror.rackspace.com/archlinux/iso/latest/arch/boot/intel_ucode.img)<br>
[Image x86_64](http://mirror.rackspace.com/archlinux/iso/latest/arch/boot/x86_64/archiso.img)<br>
[Download from the official site](https://www.archlinux.org/download/)<br>

Setup your USB and load the image.<br>
[USB flash installation media](https://wiki.archlinux.org/index.php/USB_flash_installation_media)


### 2. Init
Reboot your computer with your bootloader USB and start with the USB.

1. Select the first option which is ????????.

2. Wait for the login session, if it requires a user you can press [enter] or write root.

3. The first thing you should to do is download the "init script" to start this journey.<br>
```sh
curl https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/01-init/init.sh > init.sh
chmod +x init.sh


```

This script create a directory which name is "archLinux-installer-and-setup-master", this directory contains all the scripts to install and setup your Arch Linux.
