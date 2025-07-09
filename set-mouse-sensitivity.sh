#!/bin/bash

MOUSE_NAME="HS6209 A4tech 2.4G Wireless Device Mouse"
MOUSE_ID=$(xinput list --id-only "$MOUSE_NAME")

# Set sensitivity and profile (specify type)
xinput set-prop "$MOUSE_ID" "libinput Accel Speed" --type=float -0.8
xinput set-prop "$MOUSE_ID" "libinput Accel Profile Enabled" 0, 1