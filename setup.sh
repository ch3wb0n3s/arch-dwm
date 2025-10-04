#!/usr/bin/env bash

sudo pacman -Syu --noconfirm --needed vim git fastfetch base-devel openssh less

sudo systemctl enable sshd
sudo systemctl start sshd


# make directories and clone repo from which dwm configs will be set
mkdir .local
cd .local
mkdir src
cd src
git clone https://github.com/ibrahimahtsham/arch-dwm.git
cd arch-dwm

# ask username and email to set git config
read -p "Enter your git username: " git_username
read -p "Enter your git email: " git_email
git config --global user.name "$git_username"
git config --global user.email "$git_email"

git config --global --list