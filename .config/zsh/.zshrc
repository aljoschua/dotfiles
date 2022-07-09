
dir=$ZDOTDIR

fpath+=($dir/functions/*/)
autoload -z $dir/functions/*/*

for file in $dir/zshrc.d/*; do
    source "$file"
done
