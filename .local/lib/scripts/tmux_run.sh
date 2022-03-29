#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later

st -c shellux -- tmux new-session -As scratch &
tmux new-window -t scratch:
tmux send-keys -t scratch: "$1" "$2" $(for i in $(seq ${#2}); do echo "Left"; done) C-l
