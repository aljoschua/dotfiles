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

## How I manage my dotfiles
I've tried out various approaches for keeping track of my dotfiles. After a long endeavor of creating my own symlink manager, which I never felt ready to publish, I stumbled upon git-managed dotfiles.
The more you think about it, git has all the functionality you would want for your dotfiles.
All the setup you need is:

```bash
cd
git init
git config status.showuntrackedfiles no
```

What you will come to realize is that, almost all other git commands ignore untracked files from the get-go.
You only have to be careful when using git-add recursively (As in `git add .` or `git add -A`).
Apart from that, it can be your perfect dotfile manager too.

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
