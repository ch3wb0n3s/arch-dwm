#!/bin/bash

setxkbmap us &
xsetroot -solid "#000000" &
slstatus &

# Start clipboard manager daemon
clipmenud &

# Disable screen blanking and power saving
xset s off
xset -dpms
xset s noblank

# Set mouse sensitivity (only for A4tech mouse)
~/set-mouse-sensitivity.sh &

# Setup audio settings
~/audio-setup.sh &

# Run startup terminals
~/post-startup.sh &

# Import environment for user services (important for PipeWire)
systemctl --user import-environment DISPLAY XAUTHORITY

# Wait a bit for hardware to settle
sleep 2

# Start PipeWire and related services (safe even if enabled)
systemctl --user start pipewire pipewire-pulse wireplumber

# Give services and terminals time to launch
sleep 1

# Launch window manager
exec dbus-launch --exit-with-session dwm
