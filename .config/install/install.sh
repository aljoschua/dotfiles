#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

set -eu

_exit() echo Stacktrace: $stacktrace

_require() {
    local module
    for module; do
        stacktrace="$stacktrace $module"
        $module
        stacktrace=${stacktrace% $module}
    done
}

_install() sudo apt-get install -qy "$@"

_download() apt-get download -qy "$@"

_git_pre() {
    git clone "$1" tmp
    cd tmp
    # assuming latest tag is latest release
    git checkout $(git rev-list --tags --max-count=1)
}

_git_post() {
    cd ..
    rm -rf tmp
}

default() {
    _require dotfiles secrets root remote_access graphical systemd_units tub general
    [ -e f ] && rm f
    sudo apt-get install -qy ./*.deb
    rm ./*.deb
    apt-mark showmanual > current.lst
    diff current.lst .config/install/aptmanual.lst > apt.diff || true
    rm current.lst
    echo "TODO:"
    echo "View ~/apt.diff to find programs which weren't installed"
    echo reboot
}

dotfiles() (
    [ -d ~/.config/dotfiles ] && return
    _require base
    export GIT_DIR=$HOME/.config/dotfiles GIT_WORK_TREE=$HOME
    git clone --bare https://aljoschua@github.com/aljoschua/dotfiles $GIT_DIR
    git checkout @ -- $GIT_DIR
    git -c user.name=a -c user.email=a stash
    git checkout
)

base() {
    command -v wget && return
    _install wget curl zip git
}

terminal() { # Terminal applications
    command -v tmux && return
    _download tmux neovim zsh docker.io git ncdu asciinema inotify-tools
    sudo usermod -aG docker $USER
    sudo chsh -s /usr/bin/zsh
    sudo chsh -s /usr/bin/zsh $USER
}

secrets() (
    [ -d ~/.config/secrets ] && return
    export GIT_DIR=$HOME/.config/secrets GIT_WORK_TREE=$HOME
    git clone --bare https://aljoschua@github.com/aljoschua/secrets $GIT_DIR
    git checkout @ -- $GIT_DIR
    git stash
    git checkout
)

root() { # Installs root dotfiles, secrets and various other things
    _require base
    sudo su -c 'set -e; cd
    [ -d .config/dotfiles ] && exit
    for repo in .config/{dotfiles,secrets}; do
        export GIT_DIR=$HOME/$repo GIT_WORK_TREE=/
        eval git clone --bare -b root ~$SUDO_USER/$repo $GIT_DIR
        git checkout @ -- $GIT_DIR
        git -c user.name=a -c user.email=a stash
    done
    eval ln -s ~$SUDO_USER ~/.portal
    git checkout
    for key in download.spotify.com/debian/pubkey_0D811D58.gpg \
        mega.nz/keys/MEGA_signing.key \
        dl.google.com/linux/linux_signing_key.pub; do
            wget -qO- $key | apt-key add -
        done
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5E3C45D7B312C643
        apt-get update
        systemctl disable cups.service || true
        '
    }

remote_access() {
    _download openssh-server
}

graphical() {
    _require root wm libinput_gestures dunst chrome bitwarden rclone
    command -v xclip && return
    _download xclip remmina remmina-plugin-vnc kdeconnect gparted \
        ssh-askpass-gnome screenkey signal-desktop google-chrome-stable \
        spotify-client autorandr
    sudo usermod -aG video $USER # Allow usage of video devices
    sudo usermod -aG plugdev $USER # Allow mounting
}

wm() {
    _download i3 dmenu wmctrl sxhkd zenity xdotool xcompmgr xkbset
}

libinput_gestures() {
    command -v libinput-gestures-setup && return
    _download xdotool wmctrl libinput-tools zenity
    _git_pre hub:bulletmark/libinput-gestures
        sudo make install
    _git_post
    sudo usermod -aG input $USER
    libinput-gestures-setup autostart
}

dunst() {
    command -v dunst && return
    _install dbus libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev \
        libpango1.0-dev libgtk-3-dev libnotify-dev
    _git_pre hub:dunst-project/dunst
        make WAYLAND=0
        sudo make WAYLAND=0 install
    _git_post
}

bitwarden() {
    _require base
    command -v bw && return
    wget -O bw.zip 'https://vault.bitwarden.com/download/?app=cli&platform=linux'
    unzip -d ~/.local/bin bw.zip
    chmod +x ~/.local/bin/bw
    rm bw.zip
}

rclone() {
    _require base
    command -v rclone && return
    wget -O rclone.deb downloads.rclone.org/rclone-current-linux-amd64.deb
    sudo apt-get install -qy ./rclone.deb
    rm rclone.deb
}

tub() {
    _require tq base
    command -v openconnect && return
    _download krb5-user openconnect
}

tq() {
    command -v tq && return
    sudo pip3 install https://github.com/plainas/tq/zipball/stable
}

systemd_units() {
    systemctl --user daemon-reload
}

dconf() {
    command dconf load / < .config/dconf/settings.dconf
}

trap _exit EXIT
cmd=${1:-default}
stacktrace=$cmd

$cmd
trap - EXIT
