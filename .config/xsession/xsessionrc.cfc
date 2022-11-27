{
    setxkbmap -option caps:swapescape -option terminate:ctrl_alt_bksp
    xkbset exp =st; xkbset -sticky -twokey -latchlock
script_begin
name=$(xinput list --name-only | grep -m1 Touchpad) &&
echo "    xinput set-prop '$name' 'libinput Tapping Enabled' 1"
script_end

    systemd-inhibit --what=handle-power-key sleep infinity &

    systemctl --user --no-block start graphical.target
} &
