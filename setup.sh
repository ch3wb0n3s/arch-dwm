#!/usr/bin/env bash

sudo pacman -Syu --noconfirm --needed vim git fastfetch base-devel ttf-dejavu

sudo systemctl enable sshd
sudo systemctl start sshd

# make directories and clone repo from which dwm configs will be set
mkdir .local
cd .local
mkdir src
cd src
git clone https://github.com/ibrahimahtsham/arch-dwm.git
cd arch-dwm

# clone dwm and other suckless tools
git clone https://aur.archlinux.org/dwm.git
cd dwm
rm -rf .git

# make dwm
makepkg -Ccfsi --noconfirm

# put exec dwm in .xinitrc
cd ~
echo "exec dwm" > .xinitrc
