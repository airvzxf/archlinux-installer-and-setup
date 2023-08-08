#!/bin/bash

# ----------------------------------------------------------------------
# Arch Linux :: Setup
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

# ----------------------------------------------------------------------
# Official Linux Games
# ----------------------------------------------------------------------

# FreedroidRPG — Mature science fiction role playing game set in the future
sudo pacman --sync --needed --noconfirm freedroidrpg

# OpenMW — Attempt to reimplement the popular role-playing game Morrowind. OpenMW aims to be a fully playable, open source implementation of the game's engin
sudo pacman --sync --needed --noconfirm openmw

# Cube 2: Sauerbraten — Improved version of the Cube engine.
sudo pacman --sync --needed --noconfirm sauerbraten

# Urban Terror — Modern multiplayer FPS based on the ioquake3 engine.
yay -S --needed --noconfirm urbanterror

# Flight Gear — Open-source, multi-platform flight simulator.
sudo pacman --sync --needed --noconfirm flightgear

# Oolite — 3D space trading and combat simulator in the spirit of Elite.
sudo pacman --sync --needed --noconfirm oolite

# Globulation 2 — Multiplayer RTS with some "economic" elements minimizing the amount of micromanagement.
sudo pacman --sync --needed --noconfirm glob2

# The Battle for Wesnoth — Free, turn-based tactical strategy game with a high fantasy theme, featuring both single-player, and online/hotseat multiplayer combat.
sudo pacman --sync --needed --noconfirm wesnoth

# Simutrans — Another Transport simulation that works on linux with sdl.
sudo pacman --sync --needed --noconfirm simutrans

# OpenTTD — Open source clone of the Microprose game "Transport Tycoon Deluxe", a popular game originally written by Chris Sawyer. It attempts to mimic the original game as closely as possible while extending it with new features.
sudo pacman --sync --needed --noconfirm openttd

# Lincity-ng — City simulation game in which you are required to build and maintain a city. You can win the game either by building a sustainable economy or by evacuating all citizens with spaceships.
sudo pacman --sync --needed --noconfirm lincity-ng

# Dofus — Free, manga inspired, Massively Multiplayer Online Role-playing Game (MMORPG) for Adobe AIR
yay -S --needed --noconfirm dofus #AUR

#      Savage 2: A Tortured Soul — Fantasy themed online multiplayer team-based FPS/RTS/RPG hybrid. Free-to-play as of December 2008. Pay for premium accounts providing crucial game elements such as extra inventory slots, access to clans and removal of the Hellbourne unit restrictions (per-account), as well as access to replays and stats.
yay -S --needed --noconfirm savage2 #AUR

# Planeshift — Role Playing Game immersed into a 3D virtual fantasy world which is FULLY FREE to play. Fully free means you will have no surprises of premium content which will limit your gameplay or unbalance the game. There are no limitations in skills, ranks, abilities, items you can gain with your free account
yay -S --needed --noconfirm planeshift #AUR

# RuneScape — Massive online adventure game by Jagex
yay -S --needed --noconfirm runescape-launcher #AUR (new NXT client)

# Ryzom — 3D Fantasy MMORPG
yay -S --needed --noconfirm ryzom-client #AUR
