rename-window -t 1 main
send-keys -t 1. "-\nvi info\n"

new-window -n evm-history
send-keys "vi -S\n"

source-file ~/.config/ws/thesis_geth.tmux
