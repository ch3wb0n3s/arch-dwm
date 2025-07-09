#!/bin/bash
# filepath: /home/siamax/startup.sh

update_system() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "        UPDATING SYSTEM           "
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    echo "Updating pacman database and packages..."
    sudo pacman -Syu
    
    if command -v yay &> /dev/null; then
        echo "Updating AUR packages with yay..."
        yay -Syu
    else
        echo "yay not found, skipping AUR updates"
    fi
    
    echo "System update complete!"
    read -p "Press Enter to return to menu..."
}

check_version() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "        CHECK APP VERSION         "
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    read -p "Enter app name to check version: " app_name
    
    if [ -z "$app_name" ]; then
        echo "No app name provided."
        read -p "Press Enter to return to menu..."
        return
    fi
    
    echo "Checking version for: $app_name"
    echo
    
    # Try different methods to get version
    if command -v "$app_name" &> /dev/null; then
        echo "App found in PATH. Trying common version flags:"
        echo "----------------------------------------"
        
        # Try --version
        if $app_name --version 2>/dev/null; then
            echo
        # Try -v
        elif $app_name -v 2>/dev/null; then
            echo
        # Try version subcommand
        elif $app_name version 2>/dev/null; then
            echo
        else
            echo "Could not determine version using standard flags"
        fi
        
        echo "----------------------------------------"
        echo "Checking with pacman..."
        pacman -Qi "$app_name" 2>/dev/null | grep -E "^(Name|Version)" || echo "Not found in pacman database"
        
        if command -v yay &> /dev/null; then
            echo "Checking with yay..."
            yay -Qi "$app_name" 2>/dev/null | grep -E "^(Name|Version)" || echo "Not found in yay database"
        fi
    else
        echo "App '$app_name' not found in PATH"
        echo "Checking package managers..."
        echo "----------------------------------------"
        
        pacman -Qi "$app_name" 2>/dev/null | grep -E "^(Name|Version)" || echo "Not found in pacman database"
        
        if command -v yay &> /dev/null; then
            yay -Qi "$app_name" 2>/dev/null | grep -E "^(Name|Version)" || echo "Not found in yay database"
        fi
    fi
    
    echo
    read -p "Press Enter to return to menu..."
}

update_specific_app() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "      UPDATE SPECIFIC APP         "
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    read -p "Enter app name to update: " app_name
    
    if [ -z "$app_name" ]; then
        echo "No app name provided."
        read -p "Press Enter to return to menu..."
        return
    fi
    
    echo "Attempting to update: $app_name"
    echo
    
    # Try pacman first
    if pacman -Qi "$app_name" &> /dev/null; then
        echo "Found in pacman. Updating with pacman..."
        sudo pacman -S "$app_name"
    elif command -v yay &> /dev/null && yay -Qi "$app_name" &> /dev/null; then
        echo "Found in AUR. Updating with yay..."
        yay -S "$app_name"
    else
        echo "Package '$app_name' not found in pacman or AUR databases."
        echo "You might want to check the exact package name or install it first."
    fi
    
    echo
    read -p "Press Enter to return to menu..."
}

show_menu() {
    clear
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "           STARTUP MENU            "
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "1. Start X Window System"
    echo "2. Run fastfetch"
    echo "3. Update system (pacman + yay)"
    echo "4. Check app version"
    echo "5. Update specific app"
    echo "c. Continue to shell"
    echo "q. Exit (logout)"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "To run this menu again, type: ./startup.sh"
    echo
}

show_menu
read -p "Enter your choice: " choice

case $choice in
    1)
        echo "Starting X Window System..."
        startx
        ;;
    2)
        echo "Running fastfetch..."
        fastfetch
        read -p "Press Enter to continue to shell..."
        ;;
    3)
        update_system
        exec "$0"  # Restart the script to show menu again
        ;;
    4)
        check_version
        exec "$0"  # Restart the script to show menu again
        ;;
    5)
        update_specific_app
        exec "$0"  # Restart the script to show menu again
        ;;
    c|C)
        echo "Continuing to shell..."
        ;;
    q|Q)
        echo "Logging out..."
        exit
        ;;
    *)
        echo "Invalid option. Continuing to shell..."
        ;;
esac

# No loop - script will naturally end here and return control to shell