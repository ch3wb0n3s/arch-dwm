#!/bin/bash
# filepath: /home/siamax/post-startup.sh

sleep 5

# Launch terminal with htop (first)
kitty -e htop &
sleep 0.5

# Launch terminal with fastfetch (second)
kitty -e bash -c "fastfetch; exec bash" &
sleep 0.5

# Create function to display shortcuts in terminal
show_shortcuts() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "                    NOTES                    "
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo
    echo "SCRIPTS (in ~/):"
    echo "audio-setup.sh         # Audio device setup script"
    echo "set-max-performance.sh # Set CPU to max performance"
    echo "set-mouse-sensitivity.sh # Adjust mouse sensitivity"
    echo
    echo "COMMON PROGRAMS:"
    echo "code         # VS Code editor"
    echo "firefox      # Web browser"
    echo "discord      # Chat/voice app"
    echo "pavucontrol  # Audio control panel"
    echo "thunar       # File manager"
    echo "scrot        # Screenshot tool"
    echo "kitty        # Terminal emulator"
    echo
    echo "DWM SHORTCUTS:"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "WINDOW MANAGEMENT:"
    echo "MOD+SHIFT+ENTER    Open terminal"
    echo "MOD+j              Focus next window"
    echo "MOD+k              Focus previous window"
    echo "MOD+SHIFT+c        Close focused window"
    echo "MOD+h              Decrease master area width"
    echo "MOD+l              Increase master area width"
    echo "MOD+i              Increment number of masters"
    echo "MOD+d              Decrement number of masters"
    echo
    echo "WINDOW MOVEMENT:"
    echo "MOD+Mouse1         Move floating window (drag)"
    echo "MOD+Mouse3         Resize floating window (drag)"
    echo "MOD+SPACE          Toggle floating for window"
    echo "MOD+Mouse2         Toggle floating for window"
    echo
    echo "TAG MANAGEMENT:"
    echo "MOD+1-9            Switch to tag 1-9"
    echo "MOD+SHIFT+1-9      Move window to tag 1-9"
    echo "MOD+0              View all tags"
    echo "MOD+SHIFT+0        Apply window to all tags"
    echo
    echo "LAYOUTS:"
    echo "MOD+t              Set tiled layout"
    echo "                   (Main area on left, stack on right)"
    echo
    echo "MOD+f              Set floating layout"
    echo "                   (Windows can be moved and resized freely)"
    echo
    echo "MOD+m              Set monocle layout"
    echo "                   (One window displayed in fullscreen at a time)"
    echo
    echo "MOD+SHIFT+SPACE    Toggle between previous layouts"
    echo
    echo "SYSTEM:"
    echo "MOD+SHIFT+q        Quit DWM"
    echo
    echo "(Press Ctrl+C to close this window)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    read -r
}

# Launch terminal with shortcuts and resize it
kitty -e bash -c "$(declare -f show_shortcuts); show_shortcuts" &
# resize using super + h
sleep 1
xdotool key super+h
xdotool key super+h
xdotool key super+h
xdotool key super+h
xdotool key super+h