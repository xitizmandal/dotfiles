#!/usr/bin/env bash


main() {
    local black="#181a1f"
    local bg0="#282c34"
    local bg1="#31353f"
    local bg2="#393f4a"
    local bg3="#3b3f4c"
    local bg_d="#21252b"
    local bg_blue="#73b8f1"
    local bg_yellow="#ebd09c"
    local fg="#abb2bf"
    local purple="#c678dd"
    local green="#98c379"
    local orange="#d19a66"
    local blue="#61afef"
    local yellow="#e5c07b"
    local cyan="#56b6c2"
    local red="#e86671"
    local grey="#5c6370"
    local light_grey="#848b98"
    local dark_cyan="#2b6f77"
    local dark_red="#993939"
    local dark_yellow="#93691d"
    local dark_purple="#8a3fa0"
    local diff_add="#31392b"
    local diff_delete="#382b2c"
    local diff_change="#1c3448"
    local diff_text="#2c5372"
    # local green='#98c379'
  # local dark_green='#00af87'
  # local white='#abb2bf'
  # local black='#282c34'
  # local comment_grey='#5c6370'
  # local menu_grey='#3e4452'
  # local special_grey='#3b4048'

  tmux set-option -g mode-style 'bg=#3e4452'
  tmux set-option -g status-bg "${bg0}"

  tmux set-option -g status-style "bg=${comment_grey}"
  tmux set-option -g status-left ' #S '
  tmux set-option -g status-left-style "bg=${purple},fg=${black}"

  tmux set-window-option -g window-status-format ' #I:#W '
  tmux set-window-option -g window-status-style "bg=${bg_blue}"
  tmux set-window-option -g window-status-current-format ' #I:#W '
  tmux set-window-option -g window-status-current-style "bg=${green},fg=${black}"
  tmux set-window-option -g window-status-separator ''
  
  tmux set-option -g status-right ""

}

main

