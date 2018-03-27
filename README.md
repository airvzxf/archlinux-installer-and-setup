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
   This script helps to download the archLinux project in your computer to proceed with the installation.<br>
```sh
cd ~/

# This is the MSI short link
curl -L https://goo.gl/vkE1DS > init.sh

# For MSI Laptop
#curl https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/src/laptop_ASUS_K46CB/02-init/init.sh > init.sh

For ASUS Laptop
#curl https://raw.githubusercontent.com/airvzxf/archLinux-installer-and-setup/master/src/laptop_MSI_GT73EVR_7R_Titan_Pro/02-init/init.sh > init.sh

chmod +x init.sh
./init.sh


```




### 3. Install
Install Arch Linux in your Hard Disk Device<br>
If you are executing these scripts in this project, please go to this path:
```sh
cd ~/workspace/archLinux-installer-and-setup-master/03-installer


```

1. Pre-installation.<br>
   Clean/Erease your hard disk and format ever partition then create the files systems.
```sh
./01b-pre-installation-efi.sh


```

2. Installation.<br>
   Download and install the base packages in your Linux partition and create the automatically mount partitions.
```sh
./02-installation.sh


```

3. Arch change Root.<br>
   Emulate that you are login in the mount device and every command affect your session, setup the basic config to start to run Arch Linux in your Hard Drive Device.
   - Reboot the computer
```sh
./03-arch-change-root.sh


```



### 4. Setup
Install all the basic packages including the graphic drivers and window manager also set up the properties in some files to improve your experience.
```sh
cd ~/workspace/archLinux-installer-and-setup-master/04-setup


```

1. Connect to internet.
   - If your computer is not connected with ethernet wire you need to setup the wifi with this command.
```sh
# Select your network and write your password.
sudo wifi-menu
```

2. 01-setup.sh
   - Create workspace folder and others into home directory.
   - Install and set up reflector.
   - Install yaourt.
   - Install alsa audio.

3. 02-xorg.sh
   - Install xorg.

4. 03a-graphic-card-generic.sh
   - Keyboard configuration.

5. 03b01-graphic-card-nvidia.sh
   - Install Nvidia graphic card.
   - Reboot the computer.

6. 03b02-graphic-card-nvidia-startx.sh
   - Start the openbox window manager.

7. 03b03-graphic-card-nvidia-gui.sh
   - Run Xconfig.
   - Run at first time acpid service.

8. 04-basics.sh
   - Install a lot of packages: editor, web browser, media player, etc.

9. 05a-boinc.sh
   - Install boinc.
   - Needs logout and login again from your windows manager.

10. 05b-boinc-after-install.sh
    - Set up boinc.

11. 06-video-games.sh
    - Install general package for almost video games.

12. 07-steam.sh
    - Install and set up Steam.




### 5. Knowledge
This interesting folder contain resources, configurations, information, link references, errors and solutions, etc.
```sh
cd ~/workspace/archLinux-installer-and-setup-master/05-knowledge


```
