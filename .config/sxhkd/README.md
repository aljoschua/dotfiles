# Simple X Hotkey Daemon Configuration
This is my sxhkd config. I introduced a concept of modes similar to i3 modes.
See [how I start up sxhkd](/.config/systemd/user/sxhkd.service).

## Modes

To emulate i3 modes, I added a little script `switch` which points sxhkdrc to a file in `modes/` and then instructs sxhkd to reload its configuration file. It can also display text specified in the mode file if its first line looks like "#modeinfo: ...".
Additionally, there is a custom shell `shell` which is just a wrapper around $SHELL with two features:
- It unsets some enviroment variables I don't want in programs invoked with sxhkd
- It invokes `switch default` to switch back to the default mode if the command begins with an exclamation mark
