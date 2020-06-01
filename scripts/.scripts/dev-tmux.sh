#!/bin/sh
# tmux new-session -d 'vim'
# tmux split-window -v 'ipython'
# tmux split-window -h 'ipython'
# tmux attach-session -d

tmux new-session \; \
  send-keys 'vim' C-m \; \
  split-window -v -p 30 \; \
  send-keys 'conda activate ' $1 C-m \; \
  split-window -h \; \
  send-keys 'conda activate ' $1 C-m \; \
  send-keys 'python3' C-m \; 
