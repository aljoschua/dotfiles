for file in $ZDOTDIR/zshrc.d/*; do
    source "$file"
done

return
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._- ]=** r:|=**'
zstyle :compinstall filename '/home/aljoschua/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
