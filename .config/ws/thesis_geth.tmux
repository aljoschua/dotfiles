kill-window -t thesis:Geth
new-window -n Geth 'source source.zsh; geth'
set-option -p remain-on-exit

split-window -v
send-keys "cd truffle-history\ntruffle console\n"
set-buffer -b truffle-setup "migrate\nacc = (await web3.eth.getAccounts())[0]\ncontract = await CallPrecompiledContract.deployed()\ncontract.run(acc, {from: acc})"
bind-key R respawn-pane -kt thesis:Geth.{top} \; paste-buffer -b truffle-setup -t thesis:Geth.{bottom} \; select-window -t thesis:Geth
