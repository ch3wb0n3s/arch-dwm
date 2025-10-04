#!/usr/bin/env bash

sudo pacman -Syu --noconfirm --needed vim git fastfetch base-devel

sudo systemctl enable sshd
sudo systemctl start sshd


# make directories and clone repo from which dwm configs will be set
mkdir .local
cd .local
mkdir src
cd src
git clone https://github.com/ibrahimahtsham/arch-dwm.git
cd arch-dwm

