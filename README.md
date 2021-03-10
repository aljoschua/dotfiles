# Dotfiles - root
These are my configuration files for the root user.
## Setup
As root, execute (assuming you already cloned my user dotfiles):
```bash
git clone --bare ~aljoschua/.config/dotfiles -b root ~/.config/dotfiles
alias dot="git --git-dir=$HOME/.config/dotfiles --work-tree=/"
dot checkout @ -- /root/.config/dotfiles
dot -c user.name=a -c user.email=a stash
dot co # apply post-checkout hook to fix-permissions
```

## Undo Setup
Assuming you haven't added more stash entries:
```bash
dot stash pop
unalias dot
rm -rf ~/.config/dotfiles
```
