#!/usr/bin/env bash

set -e

sudo apt-get update
sudo apt-get -qy install git python3 python3-pip
pip3 install setuptools pyyaml argparse coloredlogs

cd
git clone --bare https://github.com/aljoschua/dotfiles .config/dotfiles
dot() {
    git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME "$@"
}
dot checkout @ -- .config/dotfiles
dot -c user.name=a -c user.email=a stash
[ -t 0 ] && .config/install/install.py
exit 0
