#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later

revert() {
  xset dpms 0 0 0
  dunstctl set-paused false
}
trap revert HUP INT TERM

xset +dpms dpms 5 5 5
dunstctl set-paused true

slock
revert
