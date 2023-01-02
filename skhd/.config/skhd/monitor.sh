#!/usr/bin/env bash
N_MONITOR=$(yabai -m query --displays | jq '. | length')

if [ $N_MONITOR -lt 2 ]
then
    exit -1
fi

MONITOR_INDEX=$(yabai -m  query --displays --display | jq '.index')
echo $MONITOR_INDEX
# change monitor number
if [ $MONITOR_INDEX -eq 1 ]
then
    yabai -m space --display 2
else 
    yabai -m space --display 1
fi
