# Arch Linux: Installer and setup

Arch Linux is a great distro but I spend a lot of time installing and setting up with my preferences then here are some scripts for execute all of this stuff or understand how the Arch Linux works.

---

## Steps
### 1. Create your bootloader USB to boot with Arch Linux
[Arch Linux official documentation.](https://wiki.archlinux.org/index.php/USB_flash_installation_media)

- This project has a script to [create a USB flash installation media](https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/01-bootable-usb/bootable-usb.sh)

Or

- Download the Arch Linux image.<br>
[The official server](http://mirror.rackspace.com/archlinux/iso/latest/)<br>
[Download from the official site](https://www.archlinux.org/download/)<br>

- Create the bootable USB in GNU/Linux
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
Reboot your computer with your bootloader USB plugged in your computer and init the system with the USB.

1. Select the first option which is "Arch Linux archiso x86_64 UEFI CD".

2. Wait for the login session, if it requires a user you can write root and press [enter].

3. Connect to internet.
   - If your computer is not connected with ethernet wire you need to setup the wifi with this command.
```sh
# Select your network and write your password.
sudo wifi-menu
```

4. Download the "init script" to start this journey.<br>
   This script should be downloaded in `~/workspace/archLinux-installer-and-setup-master`
```sh
curl https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/02-init/init.sh > init.sh
chmod +x init.sh
./init.sh
cd ~/workspace/archLinux-installer-and-setup-master


```


### 3. Installer
