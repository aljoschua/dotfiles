# window 0
rename-window -t 1 main
send-keys -t 1. "vim info\n"

# window 1
new-window -n proposal
send-keys "cd thesis-proposal\nvim -S\n\n"

# window 2
new-window -n geth
send-keys "cd evm-history\nsource dev/source.zsh\nvim -S\n"
