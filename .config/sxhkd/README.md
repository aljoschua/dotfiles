# Simple X Hotkey Daemon Configuration
This is my sxhkd config. I introduced a concept of modes similar to i3 modes.
Executing `~/.config/sxhkd/switch {mode}` symlinks modes/{mode} to the sxhkdrc and then reloads sxhkd.

Additionally, I am declaring a custom shell in sxhkd.service to add the ! commandline modifier.

