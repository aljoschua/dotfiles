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

All of these have their configuration files in `.config/`.
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

Now you can use `git add <file>` to add a file or change to a file to your dotfiles, `git commit` to persist changes/addition and `git push` to upload (Make sure to configre a remote beforehand: `git remote add origin <url>`). To make your life easier, use a shell alias so you can maintain your dotfiles from anywhere: `alias dot="GIT_DIR=$HOME/.git GIT_WORK_TREE=$HOME git"`.

What you will come to realize is that, almost all other git commands ignore untracked files from the get-go.
You only have to be careful when using git-add recursively (As in `git add .` or `git add -A`).
Apart from that, it can be your perfect dotfile manager too.

## Setup
To try out my dotfiles without deleting any of yours, invoke:
```bash
git clone --bare https://github.com/aljoschua/dotfiles ~/.config/dotfiles
alias dot="GIT_DIR=$HOME/.config/dotfiles GIT_WORK_TREE=$HOME git"
dot checkout @ -- .config/dotfiles
dot -c user.name=a -c user.email=a stash
```
Alternatively, you can issue `wget -O- git.io/JqcSG|sh` (links to [https://raw.githubusercontent.com/aljoschua/dotfiles/main/.config/install/remote-install.sh](https://raw.githubusercontent.com/aljoschua/dotfiles/main/.config/install/remote-install.sh))

## Undo Setup
If you're done trying out my dotfiles, you can use these commands to restore yours and delete mine, assuming you haven't added more stash entries (If you don't know what I mean, you didn't add stash entries ;)
```bash
dot stash pop
unalias dot
rm -rf ~/.config/dotfiles
```

## Install script
This script is designed to install programs I use as well as install this repository.
It does not make sense for you to run this, but you could to something similiar for yourself.
See [.config/install](.config/install) for further information.
```bash
cd
wget -Of git.io/JqcSG;GITHUB_PAT=:1ae..242 sh f
```
