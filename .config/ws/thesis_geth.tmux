kill-window -t thesis:Geth
new-window -n Geth 'source source.zsh; rm -rf ~/.ethereum/dev; geth --datadir=$HOME/.ethereum/dev --dev --http --vmdebug --log.debug'
set-option -p remain-on-exit
bind-key R respawn-pane -kt thesis:Geth.{top} \; send-keys -t thesis:Geth.{bottom} C-c "migrate\nacc = (await web3.eth.getAccounts())[0]\ncontract = await CallPrecompiledContract.deployed()\ncontract.run(acc, {from: acc})\n" \; select-window -t thesis:Geth
split-window -v
send-keys "cd truffle-history\ntruffle console\nvar acc\nvar contract\n"
bind-key T send-keys "acc = (await web3.eth.getAccounts())[0]\ncontract = await CallPrecompiledContract.deployed()\ncontract.hash2('0x', {from: acc})"

