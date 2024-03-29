# SPDX-License-Identifier: GPL-3.0-or-later
instance=$1

cd ${0%/*}
if [ -r sync-$instance ]; then
    source sync-$instance
fi

if ! type start >/dev/null; then
    start() {
        eval exec rclone sync $opts ${srcpath:-$HOME/$instance} ${dstpath:-mega:$instance}
    }
fi
