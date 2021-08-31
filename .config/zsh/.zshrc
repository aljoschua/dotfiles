
dir=$(dirname $(print -P "%N"))
for file in $dir/*; do
    source "$file"
done

[ -r "$WS_HOME/source.zsh" ] && source "$WS_HOME/source.zsh"

fpath+=($dir/functions)
autoload -Uz promptinit && promptinit
prompt segments nogit
