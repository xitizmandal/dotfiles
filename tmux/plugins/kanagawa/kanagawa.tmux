#!/usr/bin/env bash

main() {
    # local fuji_white="#dcd7ba"
    # local sumi_ink_4="#2a2a37"
    # local sumi_ink_2="#1a1a22"
    # local sumi_ink_5="#363646"
    # local sumi_ink_6="#54546D"
    # local wave_aqua="#6a9589"
    # local spring_violet_1="#938aa9"
    # local autumn_orange="#dca561"
    # local wave_red="#e46876"
    # local sakura_pink="#d27e99"
    # local ronin_yellow="#ff9e3b"
    #
    # local white=$fuji_white
    # local gray=$sumi_ink_4
    # local dark_gray=$sumi_ink_2
    # local light_purple=$sumi_ink_5
    # local dark_purple=$sumi_ink_6
    # local cyan=$wave_aqua
    # local green=$spring_violet_1
    # local orange=$autumn_orange
    # local red=$wave_red
    # local pink=$sakura_pink
    # local yellow=$ronin_yellow

    local white="#dcd7ba"
    local gray="#2a2a37"
    local dark_gray="#1a1a22"
    local light_purple="#363646"
    local dark_purple="#54546D"
    local cyan="#6a9589"
    local green="#938aa9"
    local orange="#dca561"
    local red="#e46876"
    local pink="#d27e99"
    local yellow="#ff9e3b"



    # tmux set-option -g mode-style 'bg=#3e4452'
    tmux set-option -g status-bg "${light_purple}"

    tmux set-option -g status-style "bg=${cyan}"
    tmux set-option -g status-left " #S "
    tmux set-option -g status-left-style "bg=${orange},fg=${black}"

    tmux set-window-option -g window-status-format " #I:#W "
    tmux set-window-option -g window-status-style "bg=${light_purple}, fg=${white}"
    tmux set-window-option -g window-status-current-format " #I:#W "
    tmux set-window-option -g window-status-current-style "bg=${dark_purple},fg=${orange}"
    tmux set-window-option -g window-status-separator ""

    tmux set-option -g status-right ""

}
main

