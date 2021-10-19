#!/usr/bin/env bash
set -eu

storage=$HOME/.local/share/gitbu
for repo in $(< $storage/dirs.lst); do 
    (
        cd ~/$repo
        dir=$storage/${repo//\//%}
        mkdir -p $dir
        rsync -rR $(git check-ignore $(find)) $dir
    )
done
