#!/bin/sh

NAME="$(rofi -dmenu -i -p 'Picture Name :')"
PATH_TO_OBSIDIAN=$HOME/Documents/megasync/Notes/attachments/

complete_path="${PATH_TO_OBSIDIAN}${NAME}.png"

scrot -s $complete_path
notify-send -a "Obsidian attachment" "${NAME}.png"
