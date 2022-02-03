#!/usr/bin/env bash

st -c shellux -- tmux new-session -As scratch &
tmux new-window -t scratch:
