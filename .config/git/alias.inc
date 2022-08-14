[alias]
    a = config --get-regexp 'alias.*'
    ap = add -p
    b = branch -avv
    c = commit -v
    c-a = commit -v --amend
    c-an = commit --amend --no-edit
    ca = commit -av
    ca-an = commit -a --amend --no-edit
    cl = config --show-origin --includes -l
    co = checkout
    cp = commit -vp
    dc = diff --cached
    f = fetch --all --tags --prune
    fr = !git f && git rebase
    frp = !git fr && git push
    lf = log --format=fuller --date=iso8601 --show-signature --parents --left-right
    lg = !git lo --graph
    lo = log --oneline
    ls = !git lf --author 'Aljoscha Frey' --grep
    rc = rm --cached
    rf = checkout HEAD --
    s = status -sbu --show-stash
    t = tag -as
    sw = switch
