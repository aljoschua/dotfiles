# Dotfiles - root
These are my configuration files for the root user.
These assume that dotfiles are correctly set up for a normal user.
## Setup
This will setup a "portal" (symlink to normal user) so their vim and shell configurations are used.
As root, execute:
```bash
git clone --bare https://github.com/aljoschua/dotfiles -b root ~/.config/dotfiles
alias dot="git --git-dir=$HOME/.config/dotfiles --work-tree=/"
dot checkout @ -- /root/.config/dotfiles
dot -c user.name=a -c user.email=a stash
ln -s ~<normal user> ~/.portal
```

## Undo Setup
Assuming you haven't added more stash entries:
```bash
dot stash pop
unalias dot
rm -rf ~/.config/dotfiles ~/.portal
```
