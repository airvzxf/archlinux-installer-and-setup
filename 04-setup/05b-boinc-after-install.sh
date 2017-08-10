#!/bin/bash
source 00-config.sh

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Boinc after install
# ----------------------------------------------------------------------
funcIsConnectedToInternet

echo -e ""

# After logout and login again
echo -e "Checks if 'boinc' is in your groups"
groups
echo -e ""

# Boinc work with services to start to use boinc you need to start its
# services and then open the manager to add, delete project, change
# configs, etc.
# Start the boinc service
echo -e "Start boinc service"
echo -e ""
systemctl start boinc.service
echo -e "\n"

# Other options
echo -e "Start boinc service"
echo -e ""
systemctl status boinc.service
echo -e "\n"
#systemctl stop boinc.service
#systemctl restart boinc.service

# If you run the boinc manager you always needs to execute the command
# in your home directory ~/
echo -e "Setting up the boinc config to run boinc in the home directory ~/"
cd ~/
ln -s /var/lib/boinc/gui_rpc_auth.cfg gui_rpc_auth.cfg
sudo chmod 640 gui_rpc_auth.cfg

cd ~/ && boincmgr


# Suggested projects
# https://einsteinathome.org/
# https://boinc.bakerlab.org/rosetta/

# Information
# https://boinc.berkeley.edu/wiki/Stop_or_start_BOINC_daemon_after_boot
# https://www.mankier.com/1/boinccmd
# https://boinc.berkeley.edu/wiki/Boinccmd_tool

echo -e "Ready! The next step is run './06-video-games.sh'.\n"
echo -e "Finished successfully!"
echo -e ""
