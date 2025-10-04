#!/bin/bash

set -e

build_dwm() {
    if [ -d "dwm" ]; then
        echo "Building dwm..."
        (cd dwm && sudo make clean install)
    else
        echo "dwm directory not found."
    fi
}

build_st() {
    if [ -d "st" ]; then
        echo "Building st..."
        (cd st && sudo make clean install)
    else
        echo "st directory not found."
    fi
}

build_slstatus() {
    if [ -d "slstatus" ]; then
        echo "Building slstatus..."
        (cd slstatus && sudo make clean install)
    else
        echo "slstatus directory not found."
    fi
}

restart_dwm() {
    # This will only work if you have the restartsig patch applied to dwm
    pkill -HUP dwm && echo "Sent restart signal to dwm."
    echo "If dwm did not restart, you may need to log out and log back in or use Mod+Shift+q."
}

while true; do
    echo ""
    echo "==== Build & DWM Menu ===="
    echo "1) Build dwm"
    echo "2) Build st"
    echo "3) Build slstatus"
    echo "4) Build all"
    echo "5) Restart dwm"
    echo "6) Exit"
    read -rp "Choose an option: " opt
    case $opt in
        1) build_dwm ;;
        2) build_st ;;
        3) build_slstatus ;;
        4) build_dwm; build_st; build_slstatus ;;
        5) restart_dwm ;;
        6) exit 0 ;;
        *) echo "Invalid option." ;;
    esac
done