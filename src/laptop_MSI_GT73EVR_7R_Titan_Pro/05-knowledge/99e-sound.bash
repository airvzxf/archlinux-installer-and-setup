#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Errors and problems
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

# ----------------------------------------------------------------------
# Sound
# ----------------------------------------------------------------------

# In Alsa sometimes I had problems when I watched a movie with 5.1 or
# 7.1 channels, and I used my headphones or the laptop's speakers,
#  well, my best advice is that when you will watch a movie with 5.1 or
# 7.1 channels do the following:
echo -e "pcm.!surround71 {" > ~/.asoundrc
echo -e "	type vdownmix" >> ~/.asoundrc
echo -e "	slave.pcm "aout"" >> ~/.asoundrc
echo -e "}" >> ~/.asoundrc
# With these commands, you only are able to listen to one app, for example,
# if you are watching a movie, and then you go to YouTube, you can't listen
# the YouTube video that make me sense because normally when we watch a
# movie we don't listen other stuff in the computer.
# When you finish the movie or want to restore the normal audio:
echo "" > ~/.asoundrc

# Otherwise, you can copy "the best" setup for asoundrc file.
# However, in my case it didn't work in steam games,
# maybe was because I had not installed the pulseaudio,
# well use this command if you want to copy "the best" setup
# # https://bbs.archlinux.org/viewtopic.php?id=167275
cp ./resources/asound/.asoundrc ~/
