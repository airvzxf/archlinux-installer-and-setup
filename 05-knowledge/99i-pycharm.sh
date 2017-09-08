#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Information
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# PyCharm
# [DON'T EXECUTE THIS SCRIPT, IS ONLY INFORMATIVE]
# ----------------------------------------------------------------------

pyChamDir='/home/wolf/workspace/pycharm/pycharm-2017.2.2/'
# Create a link reference to execute pycharm in anywhere
sudo ln -n $pyChamDir/bin/pycharm.sh /usr/local/bin/pycharm
sudo ln -n $pyChamDir/bin/restart.py /usr/local/bin/pycharm-restart


# Insatall optional packages
sudo pacman -S cython # (cython-kivy) (optional) – For performance debugger in Python 3
sudo pacman -S cython2 # (cython2-kivy) (optional) – For performance debugger in Python 2
sudo pacman -S docker-compose # (docker-compose-git) (optional) – For support docker inside Pycharm
sudo pacman -S docker-machine # (optional) – For support docker inside Pycharm
sudo pacman -S ipython # (optional) – For enhanced interactive Python shell v3 inside Pycharm
sudo pacman -S ipython2 # (optional) – For enhanced interactive Python shell v2 inside Pycharm
sudo pacman -S jupyter # (optional) – For support Jupyter Notebook
sudo pacman -S openssh # (openssh-git, openssh-gssapi, openssh-hpn-git, openssh-multiple-bindaddress, openssh-secp256k1, openssh-selinux) (optional) – For deployment and remote connections
sudo pacman -S python-coverage # (optional) – For support code coverage measurement for Python 3
sudo pacman -S python-pytest # (optional) – For support testing inside Pycharm with Python 3
sudo pacman -S python-setuptools # (optional) – Packages manager for Python 3, for project interpreter
sudo pacman -S python-tox # (optional) – Python environments for testing tool with Python 3,
sudo pacman -S python2-coverage # (optional) – For support code coverage measurement for Python 2
sudo pacman -S python2-pytest # (optional) – For support testing inside Pycharm with Python 2
sudo pacman -S python2-setuptools # (optional) – Packages manager for Python 2, for project interpreter
sudo pacman -S python2-tox # (optional) – Python environments for testing tool with Python 2
sudo pacman -S vagrant # (optional) – For support virtualized development environments
