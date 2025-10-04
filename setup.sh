#!/usr/bin/env bash

sudo pacman -Syu --noconfirm --needed vim git fastfetch base-devel openssh

sudo systemctl enable sshd
sudo systemctl start sshd