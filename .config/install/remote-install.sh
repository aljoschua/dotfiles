#!/usr/bin/env bash

set -e

sudo apt-get update
sudo apt-get -qy install git

cd
git clone --bare https://github.com/aljoschua/dotfiles .config/dotfiles
dot() {
    GIT_DIR=$HOME/.config/dotfiles GIT_WORK_TREE=$HOME git "$@"
}
dot checkout @ -- .config/dotfiles
dot -c user.name=a -c user.email=a stash
[ -t 0 ] && .config/install/install.sh
exit 0
