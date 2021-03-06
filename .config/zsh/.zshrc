
dir=$ZDOTDIR
for file in $dir/*; do
    source "$file"
done

[ -r "$WS_HOME/source.zsh" ] && source "$WS_HOME/source.zsh"

fpath+=($dir/{,portable-}functions/*/)
autoload -Uz $dir/{,portable-}functions/*/*

# Portable stuff
compdef _rc rc
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Non-portable stuff
compdef _d d

autoload -Uz promptinit && promptinit
prompt segments nogit
