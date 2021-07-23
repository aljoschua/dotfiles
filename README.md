# Dotfiles
These are my configuration files for varous programs, amongst other files I like to keep track of.
Here is an incomplete list:

- neovim
- zsh
- ssh
- sxhkd
- i3
- [libinput-gestures](https://github.com/bulletmark/libinput-gestures)
- dconf
- Scripts for managing workspaces

On branch `root` you can find the configuration files outside my home directory.

## Setup
```bash
git clone --bare https://github.com/aljoschua/dotfiles ~/.config/dotfiles
alias dot="git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME"
dot checkout @ -- .config/dotfiles
dot -c user.name=a -c user.email=a stash
```
Alternatively, you can issue `wget -O- git.io/JqcSG|sh` (links to [https://raw.githubusercontent.com/aljoschua/dotfiles/main/.config/install/remote-install.sh](https://raw.githubusercontent.com/aljoschua/dotfiles/main/.config/install/remote-install.sh))

## Undo Setup
Assuming you haven't added more stash entries:
```bash
dot stash pop
unalias dot
rm -rf ~/.config/dotfiles
```

## Install script
To install programs as well as all my configuration, I use:
```bash
cd
wget -Of git.io/JqcSG;GITHUB_PAT=:1ae..242 sh f
```
You can't do this step because you don't have access to my private repository.
See [.config/install](.config/install) for further information.
