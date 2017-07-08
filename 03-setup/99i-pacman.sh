#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Pacman commands
# [DON'T EXECUTE THIS SCRIPT, IS ONLY INFORMATIVE]
# ----------------------------------------------------------------------
# Pacman is the command manage the packages that's means you can install
# a web browser, calculator, etc., and update or delete packages.
# https://wiki.archlinux.org/index.php/pacman

# Update repositories and packages
sudo pacman -Syu
# Refresh mirror then update repositories and packages
sudo pacman -Syyu

# Install package
sudo pacman -S [package_name]

# Uninstall package
# Removes a single package, leaving all of its dependencies installed
sudo pacman -R [package_name]
# Removes a package and its dependencies which are not required by any other installed package
sudo pacman -Rs [package_name]

# Search remote repositories (Arch Linux database)
# https://www.archlinux.org/packages/
pacman -Ss [query_of_package_name]
# Displays extensive information
pacman -Si [query_of_package_name]

# Search the installed package
pacman -Qs [query_of_package_name]
# Displays extensive information
pacman -Qi [query_of_package_name]

# Lists a dependency tree of a package
pactree [package_name]
# List packages that depend on the named package
pactree -r [package_name]



# Problems with AUR keys when add or delete packages
# Example: vlc-2.2.4.tar.xz ... FAILED (unknown public key 7180713BE58D1ADC)
# Solve:
# gpg --recv-keys 7180713BE58D1ADC



# Exists two kind of packages the official and the AUR (Arch User Repository)
# the last one is maintained by the community developers but they are
# highly recommended.

# There are two ways to install, the first is manually and the second
# is using yaourt.

# Manually means you need to clone the git project and build the version
# for your Arch Linux, the problem is that if it needs sub libriries for
# this AUR, prepare to spend a lot of time searching and installing this dependencies.

# Yaourt solved this problem, you only need to say the name of package
# then download and build the dependencies and checks if exists problems
# with other versions of this dependencies.

# Install package
# Note: You don't need call sudo
# Note: Normally yaourt use the same options like pacman for example -Qs, -Qi, etc.
yaourt -S [package_name]
