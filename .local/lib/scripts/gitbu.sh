#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
set -eu

gitbu() {
    local git_dir
    local files
    git_dir=$(git rev-parse --git-dir)
    files=$'\n'
    # all ignored
    files+=$(find -not -path $git_dir/\* | git check-ignore --stdin) || true
    # untracked
    files+=$'\n'$(git ls-files -o --exclude-standard)
    printf '%s\n' "${files[@]}" | rsync -v --files-from=- . $1
}

storage=$HOME/.local/share/gitbu
projects=$HOME/.local/src
for repo in $(ls $projects); do 
    (
        cd $projects/$repo
        dir=$storage/${repo//\//%}
        mkdir -p $dir
        gitbu $dir
    )
done
