#!/usr/bin/env bash

revert() {
    tmux unbind-key -n Enter
}
trap revert HUP INT TERM

tmux bind-key -n Enter source-file ~/.local/lib/scripts/enter.tmux
st -c shellux -- tmux new-session -As scratch &
tmux new-window -t scratch:
wait

revert
