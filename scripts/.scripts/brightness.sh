#!/bin/bash

VALUE=10

if [[ "$1" == "inc" ]]; then
    xbacklight -inc $VALUE
elif [[ "$1" == "dec" ]]; then
    xbacklight -dec $VALUE
fi

CURRENT_BRIGHTNESS="$(xbacklight -get)"
CURRENT_BRIGHTNESS=${CURRENT_BRIGHTNESS%.*}
notify-send -a "Brightness" "$CURRENT_BRIGHTNESS"
