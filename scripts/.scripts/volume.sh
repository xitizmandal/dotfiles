#!/bin/sh
get_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | grep % | head -n 1 | cut -d '/' -f 2 | cut -d '%' -f 1
}

CURRENT_VOLUME="$(get_volume)"
# echo $CURRENT_VOLUME
dunstify -r 1100 -i audio-speaker --hints=int:value:"$CURRENT_VOLUME" -a "Volume: $CURRENT_VOLUME" ""
