# window 0
rename-window main
send-keys "vim info\n"

# window 1
new-window -n proposal
send-keys "cd ~/thesis-proposal\nvim -S\n\n"

# window 2
new-window -n geth
send-keys "cd ~/evm-getage\nsource dev/source.zsh\nvim -S\n"
