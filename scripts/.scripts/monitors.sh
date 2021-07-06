#!/bin/sh
# monitor setups
LAPTOP_DISPLAY="DP-2"
MAIN_DISPLAY="DP-0"
SECONDARY_DISPLAY="HDMI-0"


find_monitors() {
    re="\K\S+(?= connected)"
    connected=`xrandr | grep -oP "$re"`
    echo $connected
}

# dual
dual_setup() {
    xrandr --output $MAIN_DISPLAY --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
        --output $SECONDARY_DISPLAY --mode 1920x1080 --pos 0x0 --rotate right \
        --output $LAPTOP_DISPLAY --off
}

#primary
main_setup() {
    xrandr --output $MAIN_DISPLAY --primary --mode 1920x1080 --pos 0x0 --rotate normal \
        --output $SECONDARY_DISPLAY --off \
        --output $LAPTOP_DISPLAY --off
}

#secondary
secondary_setup() {
    xrandr --output $MAIN_DISPLAY --off \
        --output $SECONDARY_DISPLAY --primary --mode 1920x1080 --pos 0x0 --rotate right \
        --output $LAPTOP_DISPLAY --off
}

#laptop
laptop_setup() {
    xrandr --output $MAIN_DISPLAY --off \
        --output $SECONDARY_DISPLAY --off \
        --output $LAPTOP_DISPLAY --primary --mode 1920x1080 --pos 0x0 --rotate normal 
}

laptop_secondary() {
    xrandr --output $MAIN_DISPLAY --off \
        --output $SECONDARY_DISPLAY --mode 1920x1080 --pos 1920x0 --rotate normal \
        --output $LAPTOP_DISPLAY --primary --mode 1920x1080 --pos 0x0 --rotate normal
}

secondary_laptop() {
    xrandr --output $MAIN_DISPLAY --off \
        --output $SECONDARY_DISPLAY --mode 1920x1080 --pos 0x0 --rotate normal \
        --output $LAPTOP_DISPLAY --primary --mode 1920x1080 --pos 1920x0 --rotate normal
}

laptop_main() {
    xrandr --output $MAIN_DISPLAY --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
        --output $SECONDARY_DISPLAY --off \
        --output $LAPTOP_DISPLAY --mode 1920x1080 --pos 0x0 --rotate normal
}

main_laptop() {
    xrandr --output $MAIN_DISPLAY --primary --mode 1920x1080 --pos 0x0 --rotate normal \
        --output $SECONDARY_DISPLAY --off \
        --output $LAPTOP_DISPLAY --mode 1920x1080 --pos 1920x0 --rotate normal 
}

all_options() {
    OPTIONS=""
    OPTIONS="${OPTIONS}1. Dual\\n"
    OPTIONS="${OPTIONS}2. Laptop\\n"
    OPTIONS="${OPTIONS}3. Primary\\n"
    OPTIONS="${OPTIONS}4. Secondary\\n"
    OPTIONS="${OPTIONS}5. Laptop-Main\\n"
    OPTIONS="${OPTIONS}6. Main-Laptop\\n"
    OPTIONS="${OPTIONS}7. Laptop-Secondary\\n"
    OPTIONS="${OPTIONS}8. Secondary-Laptop\\n"
    OPTIONS="${OPTIONS}9. Quit\\n"
}

options_menu() {
    unset OPTIONS
    all_options

    case "$(echo "$OPTIONS" | rofi -dmenu -i -p 'Display :')" in
        '1. Dual') dual_setup ;;
        '2. Laptop') laptop_setup ;;
        '3. Primary') main_setup ;;
        '4. Secondary') secondary_setup ;;
        '5. Laptop-Main') laptop_main ;;
        '6. Main-Laptop') laptop_secondary ;;
        '7. Laptop-Secondary') laptop_secondary ;;
        '8. Secondary-Laptop') secondary_laptop ;;
        '9. Quit') exit 0
        esac
}

options_menu

bash ~/.config/polybar/launch.sh
