#!/bin/bash

VALUE=10

if [[ "$1" == "inc" ]]; then
    brightnessctl set $VALUE%+
elif [[ "$1" == "dec" ]]; then
    brightnessctl set $VALUE%-
fi

CURRENT_BRIGHTNESS="$(brightnessctl -m | cut -d , -f 4)"
# CURRENT_BRIGHTNESS=${CURRENT_BRIGHTNESS%.*}
dunstify -r 1200 -i computer --hints=int:value:"$CURRENT_BRIGHTNESS" -a "Brightness" "Brightness" 
