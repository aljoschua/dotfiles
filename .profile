# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/mybin" ] ; then
    PATH="$HOME/.local/mybin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -f "$HOME/.local/share/secrets/profile" ] ; then
    . "$HOME/.local/share/secrets/profile"
fi

export MANPAGER='nvim +Man!'
export EDITOR=nvim VISUAL=nvim ZDOTDIR=~/.config/zsh GNUPGHOME=~/.config/gpg
export CDPATH=~/.local/share/cdpath:~/.config:~/.local/share:~/.local/src:~/.local/lib:~/.local:~