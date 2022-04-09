#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later

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
    _require apt_update dotfiles secrets terminal root graphical systemd_units tub
    apt-mark showmanual > current.lst
    diff current.lst .config/install/aptmanual.lst > apt.diff || true
    rm current.lst
    echo "TODO:"
    echo "- View ~/apt.diff to find programs which weren't installed"
    echo - reboot
}

_require() {
    local module
    for module; do
        stacktrace="$stacktrace $module"
        $module
        stacktrace=${stacktrace% $module}
    done
}

apt_update() sudo apt-get update

dotfiles() _clone_repo dotfiles

_clone_repo() (
    [ -d ~/.config/$1 ] && return
    _require base
    export GIT_DIR=$HOME/.config/$1 GIT_WORK_TREE=$HOME
    git clone --bare https://aljoschua$GITHUB_PAT@github.com/aljoschua/$1 $GIT_DIR
    git checkout @ -- $GIT_DIR
    git -c user.name=a -c user.email=a stash
    git checkout
)

base() {
    command -v wget && command -v git && return
    _install wget curl zip git
}

_install() sudo apt-get install -qy "$@"

secrets() {
    _require dotfiles
    _clone_repo secrets
}

terminal() { # Terminal applications
    command -v tmux && return
    _require tq st
    _install tmux neovim zsh docker.io ncdu asciinema inotify-tools
    sudo usermod -aG docker $USER
    sudo chsh -s /usr/bin/zsh
    sudo chsh -s /usr/bin/zsh $USER
}

tq() {
    command -v tq && return
    _install python3-pip
    sudo pip3 install https://github.com/plainas/tq/zipball/stable
}

st() {
    [ -x .local/bin/st ] && return
    _require base
    git clone https://git.suckless.org/st
    cd st
        git checkout 0.8.4
        wget -O- st.suckless.org/patches/invert/st-invert-0.8.4.diff | patch
        make PREFIX=$HOME/.local install
        cd ..
    rm -rf st
}

root() { # Installs root dotfiles, secrets and various other things
    _require base dotfiles secrets
    sudo sh -c 'set -eu; cd
    [ -d .config/dotfiles ] && exit
    for repo in .config/dotfiles .config/secrets; do
        export GIT_DIR=$HOME/$repo GIT_WORK_TREE=/
        eval git clone --bare -b root ~$SUDO_USER/$repo $GIT_DIR
        git checkout @ -- $GIT_DIR
        git -c user.name=a -c user.email=a stash
    done
    eval ln -s ~$SUDO_USER ~/.portal
    git checkout
    for key in download.spotify.com/debian/pubkey_0D811D58.gpg \
               dl.google.com/linux/linux_signing_key.pub; do
        wget -qO- $key | apt-key add -
    done
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5E3C45D7B312C643
    apt-get update
    systemctl disable cups.service || true
    '
}

graphical() {
    command -v xclip && return
    _require root wm libinput_gestures bitwarden rclone dconf
    _install xclip kdeconnect gparted \
        ssh-askpass-gnome screenkey google-chrome-stable \
        spotify-client autorandr dunst firefox
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

dconf() {
    _require dotfiles
    command dconf load / < .config/dconf/settings.dconf
}

systemd_units() {
    _require dotfiles
    systemctl --user daemon-reload
}

tub() {
    command -v openconnect && return
    _require tq base
    _install openconnect
}

_main "$@"
