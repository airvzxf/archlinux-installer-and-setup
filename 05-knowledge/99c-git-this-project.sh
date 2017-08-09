#!/bin/bash

git global --config user.name "Israel Roldan"
git global --config user.email "israel.alberto.rv@gmail.com"
./99c-git-alias.sh

mkdir -p ~/workspace
cd ~/workspace
git clone https://github.com/airvzxf/archLinux-installer-and-setup
cd ./archLinux-installer-and-setup

rm -fR ~/archLinux-installer-and-setup-master
