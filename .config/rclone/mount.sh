instance=$1
mount_opts="--use-mmap --dir-cache-time 1000h --poll-interval 15s \
    --vfs-cache-mode full --tpslimit 10 \
    --buffer-size 16M --vfs-read-chunk-size 100M"

cd ${0%/*}
if [ -r mount-$instance ]; then
    source mount-$instance
fi

start() {
    eval exec rclone mount $instance: ~/$instance $mount_opts
}

stop() {
    fusermount -u $template
}

reload() {
    pkill -HUP -u $USER -fo "rclone mount $instance:"
}
