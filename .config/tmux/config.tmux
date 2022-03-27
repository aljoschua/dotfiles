# Server options
set-option -s escape-time 0
set-option -s default-terminal "screen-256color"
set-option -su terminal-overrides
set-option -sa terminal-overrides ',xterm-256color:RGB'

# Global session options
set-option -g base-index 1
set-option -g visual-bell on
set-option -g set-titles on
set-option -g set-titles-string "Tmux - #S:#I:#W - \"#T\" #{session_alerts}"

# Keybindings
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
bind-key -r k select-pane -U
bind-key -r j select-pane -D
bind-key -r h select-pane -L
bind-key -r l select-pane -R
bind-key b last-window
bind-key x kill-pane
bind-key -n Enter {
    if-shell "true" {
        %if "#{&&:#{==:#S,scratch},#{==:#W,zsh}}"
            detach-client
            send-keys -t scratch: Escape "Isleep .1 && " Escape "A && exit"
        %endif
    }
    send-keys Enter
}
bind-key -n C-j {
    if-shell "true" {
        %if "#{&&:#{==:#S,scratch},#{==:#W,zsh}}"
            detach-client
            send-keys -t scratch: Escape "Ix-terminal-emulator -- " Escape "A &! exit"
        %endif
    }
    send-keys C-j
}
