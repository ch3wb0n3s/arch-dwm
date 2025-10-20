#!/usr/bin/env bash

sudo pacman -Syu --noconfirm --needed vim git fastfetch base-devel ttf-dejavu ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono openssh brightnessctl alsa-utils discord firefox

# give user brightness control permissions
sudo usermod -aG video "$USER"   # then log out/in

# enable openSSH
sudo systemctl enable --now sshd

# make directories and clone repo from which dwm configs will be set
mkdir .local
cd .local
mkdir src
cd src
git clone https://github.com/ch3wb0n3s/arch-dwm.git
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
echo -e "slstatus &\nexec dwm" > ~/.xinitrc

# my sound fixes