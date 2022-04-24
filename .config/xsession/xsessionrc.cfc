#!/usr/bin/env cfc_strip
text
{
    setxkbmap -option caps:swapescape -option terminate:ctrl_alt_bksp
    xkbset exp =st; xkbset -sticky -twokey -latchlock
!text

script
name=$(xinput list --name-only | grep -m1 Touchpad)
echo "    xinput set-prop '${name:-No Touchpad Found}' 'libinput Tapping Enabled' 1"
!script

text

    systemd-inhibit --what=handle-power-key sleep infinity &

    systemctl --user --no-block start graphical.target
} &
!text
