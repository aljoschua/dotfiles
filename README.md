# Dotfiles
These are my configuration files for varous programs, amongst other files I like to keep track of.
On branch `root` you can find the configuration files outside my home directory.
## Setup
```bash
git clone --bare https://github.com/aljoschua/dotfiles ~/.config/dotfiles
alias dot="git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME"
dot checkout @ -- .config/dotfiles
dot -c user.name=a -c user.email=a stash
```

## Undo Setup
Assuming you haven't added more stash entries:
```bash
dot stash pop
unalias dot
rm -rf ~/.config/dotfiles
```
