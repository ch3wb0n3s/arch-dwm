#!/bin/bash

# Device names
SPEAKER="alsa_output.pci-0000_00_0e.0-platform-glk_da7219_def.HiFi__Speaker__sink"
HEADPHONES="alsa_output.pci-0000_00_0e.0-platform-glk_da7219_def.HiFi__Headphones__sink"
HDMI1="alsa_output.pci-0000_00_0e.0-platform-glk_da7219_def.HiFi__HDMI1__sink"
HDMI2="alsa_output.pci-0000_00_0e.0-platform-glk_da7219_def.HiFi__HDMI2__sink"
HDMI3="alsa_output.pci-0000_00_0e.0-platform-glk_da7219_def.HiFi__HDMI3__sink"
INTERNAL_MIC="alsa_input.pci-0000_00_0e.0-platform-glk_da7219_def.HiFi__Mic__source"
HEADSET_MIC="alsa_input.pci-0000_00_0e.0-platform-glk_da7219_def.HiFi__Headset__source"

# Helper to run pactl only if device exists
set_sink_volume() { pactl list short sinks | grep -q "$1" && pactl set-sink-volume "$1" "$2"; }
set_sink_mute()   { pactl list short sinks | grep -q "$1" && pactl set-sink-mute "$1" "$2"; }
set_source_volume(){ pactl list short sources | grep -q "$1" && pactl set-source-volume "$1" "$2"; }
set_source_mute() { pactl list short sources | grep -q "$1" && pactl set-source-mute "$1" "$2"; }
set_default_sink(){ pactl list short sinks | grep -q "$1" && pactl set-default-sink "$1"; }
set_default_source(){ pactl list short sources | grep -q "$1" && pactl set-default-source "$1"; }

# Set default output to speakers at 50%
set_default_sink "$SPEAKER"
set_sink_volume "$SPEAKER" 50%

# Set headphone jack to 50% (do not set as default)
set_sink_volume "$HEADPHONES" 50%

# Mute and set volume to 0% for all HDMI sinks
for SINK in "$HDMI1" "$HDMI2" "$HDMI3"; do
  set_sink_mute "$SINK" 1
  set_sink_volume "$SINK" 0%
done

#Mute and set volume to 0% for headset mic
set_source_mute "$HEADSET_MIC" 1
set_source_volume "$HEADSET_MIC" 0%

# Set internal mic as default, unmute, and set volume to 0%
set_default_source "$INTERNAL_MIC"
set_source_mute "$INTERNAL_MIC" 0
set_source_volume "$INTERNAL_MIC" 0%

# Restart PipeWire services to apply changes
# systemctl --user restart pipewire pipewire-pulse wireplumber