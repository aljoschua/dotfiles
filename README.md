# Dotfiles
These are my configuration files for varous programs, amongst other files I like to keep track of.
Note that I am on Linux Mint, and the steps below might not work for you.
On branch `root` you can find the configuration files outside my home directory.
## Setup
```bash
git clone --bare https://github.com/aljoschua/dotfiles ~/.config/dotfiles
alias dot="git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME"
dot checkout @ -- .config/dotfiles
dot -c user.name=a -c user.email=a stash
```
Alternatively, you can issue `wget -O- git.io/JqcSG|sh` (links to https://raw.githubusercontent.com/aljoschua/dotfiles/main/.config/install/remote-install.sh)

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
If you look at the `.config/install/install.yml` you might find other "modules"
that can be installed as is (e.g. `systemd-units`).

#### How it works
```yaml
module1:
  dep: [module2]    # List of modules to be installed first
  cmd:              # Commands to be executed after
    - sudo usermod -aG plugdev $USER
    - |-
      echo "multiline
      command"
module2:
  unrelated-field:
    foo: bar
  cmd: 'echo installing: dependency of module1'
```
The install process basically executes shell commands in a structured manner.
The commands are defined in the `.config/install/install.yml` file and ran by the `.config/install/install.py` script.

A module is essentially a list of commands (cmd) and a list of dependencies (dep), which are other modules to be installed first.
Before calling `os.system(cmd)` in the python script, the command list is concatenated by newlines.
The rest of the magic you can find in the yaml file is actually just neat yaml syntax.

Note that each modules commands are executed in their own shell and are aborted, if one of them exits with a non-zero exit code (due to the `set -e` in the python script).
