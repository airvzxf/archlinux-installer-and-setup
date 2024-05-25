#!/bin/bash
set -ve

# ----------------------------------------------------------------------
# Arch Linux :: Configuration
# ----------------------------------------------------------------------
# https://github.com/airvzxf/archlinux-installer-and-setup

# ----------------------------------------------------------------------
# Git
# ----------------------------------------------------------------------
# Manually set up these two options
#git config --global user.name "your_name"
#git config --global user.email "your_email"
#git config --global --list --show-origin

# Change the git editor to vim
git config --global core.editor vim

# Configure the initial branch name to use in all of your new repositories.
git config --global init.defaultBranch main

# Store your credentials
git config --global credential.helper store

# Store your password and specify the time on cache
#git config --global credential.helper cache
#git config --global credential.helper "cache --timeout=31536000" # 365 days

# Set the rebase the default option in the pull action.
git config --global pull.rebase true

# Set to true the GPP Sign to sign all commits by default.
# Set to false for commit without the .ssh private key.
# Follow the next URLs to set up this sign.
# - https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
# - https://docs.github.com/en/authentication/managing-commit-signature-verification/adding-a-gpg-key-to-your-github-account
git config --global gpg.program gpg2
git config --global user.signingKey AD66CD9F
git config --global commit.gpgsign true

# Create alias to write easy command like git cm that's means git commit -m
# These configurations will be safe in this file ~/.gitconfig
git config --global --remove-section alias || true

git config --global alias.ad '! git add "$@" && echo -e "\n" && git status'
git config --global alias.adp '! git add -p "$@" && echo -e "\n" && git status'
git config --global alias.alias "! git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /"
git config --global alias.br 'branch'
git config --global alias.cl '! git reset --hard && git clean -dfx && echo -e "\n" && git status'
git config --global alias.cm '! git commit -m "$@" && echo -e "\n" && git status'
git config --global alias.cma '! git commit -a -m "$@" && echo -e "\n" && git status'
git config --global alias.cmamend '! git commit --amend && echo -e "\n" && git status'
git config --global alias.co '! git checkout "$@" && echo -e "\n" && git status'
git config --global alias.cob '! git checkout -b "$@" && echo -e "\n" && git status'
git config --global alias.com '! git checkout master && echo -e "\n" && git status'
git config --global alias.cos 'checkout -'
git config --global alias.df '! git --no-pager diff "$@" && echo -e "\n" && git status'
git config --global alias.dfc '! git --no-pager diff --cached "$@" && echo -e "\n" && git status'
git config --global alias.dfs '! git --no-pager diff --stat "$@" && echo -e "\n" && git status'
git config --global alias.lg 'log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
git config --global alias.lglast 'log -1 HEAD'
git config --global alias.lgp 'log --pretty=format:"%C(magenta)%h%C(reset) %C(green)%as%C(reset) %C(white)%s%C(reset) %C(blue)[%cn]%C(reset)%C(yellow)%d%C(reset)" --decorate'
git config --global alias.lgwho 'shortlog -s --'
git config --global alias.pl '! git pull && echo -e "\n" && git status'
git config --global alias.ps '! git push && echo -e "\n" && git status'
git config --global alias.rs '! git reset HEAD "$@" && echo -e "\n" && git status'
git config --global alias.rss '! git reset --soft HEAD "$@" && echo -e "\n" && git status'
git config --global alias.rsh '! git reset --hard HEAD "$@" && echo -e "\n" && git status'
git config --global alias.s 'status --short --branch'
git config --global alias.st 'status'
git config --global alias.un '! git reset HEAD~ "$@" && echo -e "\n" && git status'
git config --global alias.uns '! git reset --soft HEAD~ "$@" && echo -e "\n" && git status'
git config --global alias.unstage '! git restore --staged * && echo -e "\n" && git status'
git config --global alias.unh '! git reset --hard HEAD~ "$@" && echo -e "\n" && git status'
git config --global alias.undo '! git reset HEAD~ && echo -e "\n" && git status'
git config --global alias.untrack 'ls-files . --exclude-standard --others'
git config --global alias.update '! git fetch --all && git pull --all'

# Show the config file
#git config --global --list --show-origin
git config --get user.name
git config --get user.email
git config --get core.editor
