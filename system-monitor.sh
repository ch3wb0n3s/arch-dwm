#!/bin/bash
# filepath: /home/siamax/system-monitor.sh

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Function to get Bluetooth status
get_bluetooth_status() {
    if systemctl is-active --quiet bluetooth; then
        if bluetoothctl show | grep -q "Powered: yes"; then
            echo -e "${BLUE}ON${NC}"
        else
            echo -e "${YELLOW}OFF${NC}"
        fi
    else
        echo -e "${RED}DISABLED${NC}"
    fi
}

# Function to get brightness
get_brightness() {
    if [ -f /sys/class/backlight/*/brightness ]; then
        current=$(cat /sys/class/backlight/*/brightness 2>/dev/null | head -1)
        max=$(cat /sys/class/backlight/*/max_brightness 2>/dev/null | head -1)
        if [ -n "$current" ] && [ -n "$max" ] && [ "$max" -gt 0 ]; then
            percentage=$((current * 100 / max))
            echo -e "${YELLOW}${percentage}%${NC}"
        else
            echo -e "${RED}N/A${NC}"
        fi
    else
        echo -e "${RED}N/A${NC}"
    fi
}

# Function to get CPU usage and temperature
get_cpu_info() {
    # CPU Usage
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/%us,//')
    
    # CPU Temperature - simplified from your sensors output
    temp_celsius=$(sensors | grep "Package id 0" | awk '{print $4}' | sed 's/+//;s/°C//')
    
    if [ -n "$temp_celsius" ]; then
        temp_num=$(echo $temp_celsius | cut -d'.' -f1)
        temp_color=""
        if [ $temp_num -gt 70 ]; then
            temp_color=$RED
        elif [ $temp_num -gt 50 ]; then
            temp_color=$YELLOW
        else
            temp_color=$GREEN
        fi
        echo -e "${PURPLE}${cpu_usage}%${NC} | ${temp_color}${temp_celsius}°C${NC}"
    else
        echo -e "${PURPLE}${cpu_usage}%${NC} | ${RED}N/A${NC}"
    fi
}

# Function to get RAM usage
get_ram_usage() {
    ram_info=$(free | grep Mem)
    total=$(echo $ram_info | awk '{print $2}')
    used=$(echo $ram_info | awk '{print $3}')
    percentage=$((used * 100 / total))
    
    if [ $percentage -gt 80 ]; then
        echo -e "${RED}${percentage}%${NC}"
    elif [ $percentage -gt 60 ]; then
        echo -e "${YELLOW}${percentage}%${NC}"
    else
        echo -e "${GREEN}${percentage}%${NC}"
    fi
}

# Function to get WiFi status - using your working commands
get_wifi_status() {
    ssid=$(iwgetid -r 2>/dev/null)
    if [ -n "$ssid" ]; then
        # Get signal quality from iwconfig
        signal=$(iwconfig 2>/dev/null | grep "Signal level" | awk '{print $2}' | cut -d'=' -f2)
        if [ -n "$signal" ]; then
            # Convert quality to percentage (47/70 = 67%)
            quality=$(iwconfig 2>/dev/null | grep "Link Quality" | awk '{print $2}' | cut -d'=' -f2)
            if [[ $quality == *"/"* ]]; then
                current=$(echo $quality | cut -d'/' -f1)
                max=$(echo $quality | cut -d'/' -f2)
                percent=$((current * 100 / max))
                echo -e "${GREEN}${ssid} (${percent}%)${NC}"
            else
                echo -e "${GREEN}${ssid}${NC}"
            fi
        else
            echo -e "${GREEN}${ssid}${NC}"
        fi
    else
        echo -e "${YELLOW}DISCONNECTED${NC}"
    fi
}

# Function to get volume
get_volume() {
    if command -v pactl &> /dev/null; then
        volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)
        muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -o 'yes\|no')
        if [ "$muted" = "yes" ]; then
            echo -e "${RED}MUTED${NC}"
        else
            echo -e "${CYAN}${volume}${NC}"
        fi
    else
        echo -e "${RED}N/A${NC}"
    fi
}

# Function to get battery status - using your working acpi command
get_battery_status() {
    battery_info=$(acpi -b 2>/dev/null)
    if [ -n "$battery_info" ]; then
        # Extract percentage and status
        percentage=$(echo "$battery_info" | grep -oP '\d+%' | head -1)
        status=$(echo "$battery_info" | awk '{print $3}' | sed 's/,//')
        
        # Remove % for numeric comparison
        percent_num=$(echo $percentage | sed 's/%//')
        
        if [ "$status" = "Charging" ]; then
            echo -e "${BLUE}${percentage} ⚡${NC}"
        elif [ $percent_num -gt 50 ]; then
            echo -e "${GREEN}${percentage} 🔋${NC}"
        elif [ $percent_num -gt 20 ]; then
            echo -e "${YELLOW}${percentage} 🔋${NC}"
        else
            echo -e "${RED}${percentage} 🪫${NC}"
        fi
    else
        echo -e "${CYAN}AC Power${NC}"
    fi
}

# Function to get current time
get_time() {
    echo -e "${WHITE}$(date '+%m/%d/%Y %I:%M:%S %p')${NC}"
}

# Function to display the status bar
display_status() {
    # Clear screen and move cursor to home position
    printf '\033[2J\033[H'
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "                                    ${WHITE}SYSTEM MONITOR${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    printf "%-15s %-15s | %-15s %-15s\n" "🔷 Bluetooth:" "$(get_bluetooth_status)" "💡 Brightness:" "$(get_brightness)"
    printf "%-15s %-25s | %-15s %-15s\n" "🖥️  CPU:" "$(get_cpu_info)" "🧠 RAM:" "$(get_ram_usage)"
    printf "%-15s %-25s | %-15s %-15s\n" "📶 WiFi:" "$(get_wifi_status)" "🔊 Volume:" "$(get_volume)"
    printf "%-15s %-25s | %-15s %-15s\n" "🔋 Battery:" "$(get_battery_status)" "⏰ Time:" "$(get_time)"
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${WHITE}Press Ctrl+C to exit${NC}"
}

# Hide cursor for cleaner display
tput civis

# Trap Ctrl+C to exit gracefully and restore cursor
trap 'tput cnorm; echo -e "\n\n${WHITE}System Monitor stopped.${NC}"; exit 0' INT

# Main loop
while true; do
    display_status
    sleep 1
done