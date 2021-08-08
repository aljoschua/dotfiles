
dir=$(dirname $(print -P "%N"))
for file in $dir/*; do
    source "$file"
done

fpath+=($dir/functions)
autoload -Uz promptinit && promptinit
prompt segments nogit
