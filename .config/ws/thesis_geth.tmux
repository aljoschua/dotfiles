kill-window -t thesis:Geth
new-window -n Geth 'source source.zsh; dlv debug ./cmd/geth -- --dev --http --datadir=$HOME/.ethereum/dev --rpc.evmtimeout=0 --dev.period=10'
#new-window -n Geth 'source source.zsh; geth'
set-option -p remain-on-exit

split-window -v
send-keys "cd truffle-history\ntruffle console\n"
set-buffer -b truffle-setup "migrate\nacc = (await web3.eth.getAccounts())[0]\ncontract = await CallPrecompiledContract.deployed()\ncontract.callAddr(acc, 12, {from: acc})"
bind-key R source-file ~/.config/ws/thesis_reload_geth.tmux
bind-key G send-keys 'github.com/ethereum/go-ethereum'
