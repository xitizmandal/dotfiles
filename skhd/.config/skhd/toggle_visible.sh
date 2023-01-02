#!/usr/bin/env bash
N_MONITOR=$(yabai -m query --displays | jq '. | length')

if [ $N_MONITOR -lt 2 ]
then
    echo "$N_MONITOR"
    exit -1
fi

# for focused screen
focus_index=$(yabai -m query --spaces | jq 'map(select(."is-visible" == true and ."has-focus" == true))[-1].index')
num_windows=$(yabai -m query --spaces | jq 'map(select(."is-visible" == true and ."has-focus" == true))[-1].windows | length')
focused_window=$(yabai -m query --windows | jq 'map(select(."is-visible" == true and ."has-focus" == true))[-1].id')

# for non focused screen 
non_focus_index=$(yabai -m query --spaces | jq 'map(select(."is-visible" == true and ."has-focus" == false))[-1].index')

if [ $num_windows -gt 0 ]
then
    # yabai -m window --space $non_focus_index | yabai -m space --focus $non_focus_index
    yabai -m window --space $non_focus_index | yabai -m window --focus $focused_window
else
    yabai -m space --focus $non_focus_index
fi
