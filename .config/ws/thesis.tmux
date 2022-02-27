rename-window -t 1 main
send-keys -t 1. "-\nvi info\n"

new-window -n thesis
send-keys "cd thesis-thesis\nvi -S\n\n"

new-window -n evm-history
send-keys "cd evm-history\nsource dev/source.zsh\nvim -S\n"

source-file ~/.config/ws/thesis_geth.tmux
