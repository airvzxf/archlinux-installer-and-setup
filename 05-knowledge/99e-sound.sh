#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Errors and problems
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archLinux-installer-and-setup

# ----------------------------------------------------------------------
# Sound
# ----------------------------------------------------------------------

# In Alsa sometimes I had problems when I watched a movie with 5.1 or
# 7.1 channels and I used my headphones or the laptop's speakers,
# well my best advice is that when you will watch a movie with 5.1 or
# 7.1 channels do the following:
echo -e "pcm.!surround71 {" > ~/.asoundrc
echo -e "	type vdownmix" >> ~/.asoundrc
echo -e "	slave.pcm "aout"" >> ~/.asoundrc
echo -e "}" >> ~/.asoundrc
# With this commands you only are able to listen one app for example if
# you are watching a movie and then you go to youtube, you can't listen
# the youtube video that make me sense because normally when we watch a
# movie we don't listen other stuff in the computer.
# When you finish the movie or want to restore the normally audio:
echo "" > ~/.asoundrc

# Otherwise you can copy "the best" setup for asoundrc file but in my
# case it didn't work in steam games, maybe was because I had not
# installed the pulseaudio, well use this command if you want to copy
# "the best" setup
# # https://bbs.archlinux.org/viewtopic.php?id=167275
cp ./resources/asound/.asoundrc ~/
