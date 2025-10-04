#!/usr/bin/env bash

sudo pacman -Syu --noconfirm --needed vim git fastfetch base-devel ttf-dejavu

# make directories and clone repo from which dwm configs will be set
mkdir .local
cd .local
mkdir src
cd src
git clone https://github.com/ibrahimahtsham/arch-dwm.git
cd arch-dwm

# make dwm
cd dwm
makepkg -Ccfsi --noconfirm
cd ..

# make st
cd st
makepkg -Ccfsi --noconfirm
cd ..

# make dmenu
cd dmenu-git
makepkg -Ccfsi --noconfirm
cd ..

# make slstatus
cd slstatus
makepkg -Ccfsi --noconfirm

# put exec dwm in .xinitrc
cd ~
echo "exec dwm" > .xinitrc
