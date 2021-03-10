
dir=$(dirname $(print -P "%N"))
for file in $dir/*; do
    source "$file"
done
