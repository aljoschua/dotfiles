#!/usr/bin/env bash

set -e

if command -v apt-get >/dev/null; then
    sudo apt-get -y install git python3 python3-pip
else
    echo "Couldn't find apt-get"
    exit 1
fi

pip3 install setuptools pyyaml argparse coloredlogs #logging

cd
git clone --bare https://git.tu-berlin.de/aljoschafrey/dotfiles .config/dotfiles
dot="git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME"
$dot checkout @ -- .config/dotfiles
read -sp "crypt-seed: " seed
echo "$seed" > ~/.config/dotfiles/custom/crypt-seed
$dot -c user.name=a -c user.email=a stash
echo "Now run '.config/install/install.py MODULE' (see install.py [-l|--list] for modules)"
#./install.py
