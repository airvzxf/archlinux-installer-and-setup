# Arch Linux: Installer and setup

Arch Linux is a great distro but I spend a lot of time installing and setting up with my preferences then here are some scripts for execute all of this stuff or understand how the Arch Linux works.

---

## Steps
### 1. Create your bootloader USB to boot with Arch Linux
[Arch Linux official documentation.](https://wiki.archlinux.org/index.php/USB_flash_installation_media)

- This project have an script to [create a USB flash installation media](https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/01-bootable-usb/01-bootable-usb.sh)

Or

- Download the Arch Linux image.<br>
[Image x86](http://mirror.rackspace.com/archlinux/iso/latest/arch/boot/intel_ucode.img)<br>
[Image x86_64](http://mirror.rackspace.com/archlinux/iso/latest/arch/boot/x86_64/archiso.img)<br>
[Download from the official site](https://www.archlinux.org/download/)<br>

  - In GNU/Linux
    - Use this command where sdx is your USB device, to find what is this, run sudo fdisk -l and try to search your USB and the device name. Your USB must be formatted to FAT32.<br>
   Warning: This will irrevocably destroy all data on /dev/sdx.<br>
```sh
sudo fdisk -l
sudo cfdisk /dev/sd[x]
# Delete all the partitions.
# Select: New -> Partition size [enter] -> Primary -> Enable "Bootable" -> Type -> "b W95 FAT32" -> Write -> yes -> Quite
sudo dd bs=4M if=[path_file_archlinux.iso] of=/dev/sd[x] status=progress && sync
```


### 2. Init
Reboot your computer with your bootloader USB and start with the USB.

1. Select the first option which is ????????.

2. Wait for the login session, if it requires a user you can press [enter] or write root.

3. Connecte to internet.

4. The first thing you should to do is download the "init script" to start this journey.<br>
```sh
curl https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/02-init/init.sh > init.sh
chmod +x init.sh
./init.sh


```

This script create a directory which name is "archLinux-installer-and-setup-master", this directory contains all the scripts to install and setup your Arch Linux.
