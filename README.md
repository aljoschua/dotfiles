# Dotfiles - root
These are my configuration files for the root user.
These assume that dotfiles are correctly set up at `/home/aljoschua`.
I hope this changes in the future.
## Setup
As root, execute:
```bash
git clone --bare https://github.com/aljoschua/dotfiles -b root ~/.config/dotfiles
alias dot="git --git-dir=$HOME/.config/dotfiles --work-tree=/"
dot checkout @ -- /root/.config/dotfiles
dot -c user.name=a -c user.email=a stash
```

## Undo Setup
Assuming you haven't added more stash entries:
```bash
dot stash pop
unalias dot
rm -rf ~/.config/dotfiles
```
