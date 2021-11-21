#!/usr/bin/env bash

revert() {
  xset dpms 0 0 0
  dunstctl set-paused false
}
trap revert HUP INT TERM

xset +dpms dpms 5 5 5
dunstctl set-paused true

i3lock -nc 000000
revert
