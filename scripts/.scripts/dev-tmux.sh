#!/bin/sh
# tmux new-session -d 'vim'
# tmux split-window -v 'ipython'
# tmux split-window -h 'ipython'
# tmux attach-session -d

conda_activate="conda activate"
activate_cmd="workon -n"

if [ "$2" == "conda" ]; then
    activate_cmd=$conda_activate
fi

tmux new-window \; \
  send-keys "$activate_cmd $1" C-m \; \
  send-keys 'vim' C-m \; \
  split-window -v -p 30 \; \
  send-keys "$activate_cmd $1" C-m \; \
  split-window -h \; \
  send-keys "$activate_cmd $1" C-m \; \
  send-keys 'python3' C-m \; 
