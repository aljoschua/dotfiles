respawn-pane -kt thesis:Geth.{top}
run-shell 'pkill __debug_bin'
paste-buffer -b truffle-setup -t thesis:Geth.{bottom}
send-keys -t thesis:Geth.{top} c Enter
select-window -t thesis:Geth
