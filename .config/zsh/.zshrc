
dir=$ZDOTDIR
for file in $dir/*; do
    source "$file"
done

[ -r "$WS_HOME/source.zsh" ] && source "$WS_HOME/source.zsh"

fpath+=($dir/{,portable-}functions/*/)
autoload -z $dir/{,portable-}functions/*/*

# Portable stuff
compdef _rc rc
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Non-portable stuff
compdef _d d

autoload -Uz promptinit && promptinit
prompt env

stty $(printf '%s undef ' stop start rprnt werase discard kill lnext)

setopt append_history extended_history hist_find_no_dups hist_ignore_dups
HISTFILE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh_history
HISTSIZE=1000
SAVEHIST=1000
