#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

_require() {
    local module
    for module; do
        stacktrace="$stacktrace $module"
        $module
        stacktrace=${stacktrace% $module}
    done
}

_install() sudo apt-get install -qy "$@"

_main() {
    set -eu
    cd
    cmd=${1:-default}
    stacktrace=$cmd
    trap 'echo Stacktrace: $stacktrace' EXIT
    $cmd
    trap - EXIT
}


default() {
    _require dotfiles secrets root graphical systemd_units tub
    [ -e f ] && rm f
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
    command -v wget && command -v git && return
    _install wget curl zip git
}

terminal() { # Terminal applications
    command -v tmux && return
    _install tmux neovim zsh docker.io ncdu asciinema inotify-tools
    sudo usermod -aG docker $USER
    sudo chsh -s /usr/bin/zsh
    sudo chsh -s /usr/bin/zsh $USER
}

secrets() (
    [ -d ~/.config/secrets ] && return
    _require base
    export GIT_DIR=$HOME/.config/secrets GIT_WORK_TREE=$HOME
    git clone --bare https://aljoschua@github.com/aljoschua/secrets $GIT_DIR
    git checkout @ -- $GIT_DIR
    git stash
    git checkout
)

root() { # Installs root dotfiles, secrets and various other things
    _require base dotfiles secrets
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
    _install openssh-server
}

graphical() {
    command -v xclip && return
    _require root wm libinput_gestures bitwarden rclone
    _install xclip kdeconnect gparted \
        ssh-askpass-gnome screenkey google-chrome-stable \
        spotify-client autorandr dunst
    sudo usermod -aG video $USER # Allow usage of video devices
    sudo usermod -aG plugdev $USER # Allow mounting
}

wm() {
    command -v i3 && return
    _install i3 dmenu wmctrl sxhkd zenity xdotool xcompmgr xkbset
}

libinput_gestures() {
    command -v libinput-gestures-setup && return
    _install xdotool wmctrl libinput-tools zenity
    git clone hub:bulletmark/libinput-gestures tmp
    cd tmp
        git checkout $(git rev-list --tags --max-count=1)
        sudo make install
        cd ..
    rm -rf tmp
    sudo usermod -aG input $USER
    libinput-gestures-setup autostart
}

bitwarden() {
    command -v bw && return
    _require base
    wget -O bw.zip 'https://vault.bitwarden.com/download/?app=cli&platform=linux'
    unzip -d ~/.local/bin bw.zip
    chmod +x ~/.local/bin/bw
    rm bw.zip
}

rclone() {
    command -v rclone && return
    _require base
    wget -O rclone.deb downloads.rclone.org/rclone-current-linux-amd64.deb
    sudo apt-get install -qy ./rclone.deb
    rm rclone.deb
}

tub() {
    command -v openconnect && return
    _require tq base
    _install openconnect
}

tq() {
    command -v tq && return
    _install python3-pip
    sudo pip3 install https://github.com/plainas/tq/zipball/stable
}

systemd_units() {
    systemctl --user daemon-reload
}

dconf() {
    command dconf load / < .config/dconf/settings.dconf
}

_main "$@"
