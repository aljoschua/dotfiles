#!/usr/bin/env bash
set -eu

storage=$HOME/.local/share/gitbu
projects=$HOME/.local/src
for repo in $(ls $projects); do 
    (
        cd $projects/$repo
        dir=$storage/${repo//\//%}
        mkdir -p $dir
        rsync -rR $(git check-ignore $(find)) $dir
    )
done
