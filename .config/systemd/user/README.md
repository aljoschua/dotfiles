# Systemd Units

These are my systemd units, pieces of code that regularly execute on my machine, either explicitly by me or in an automated manor.
I use systemd.timer(5) instead of cron(8) and I start graphical programs on boot with sysd as well (via the graphical.target I created).

I also track my *.target.wants/ directories to remember which units are enabled.

## Incomplete and outdated list

    - active_window: Logs the current window title as well as workspace name

      and SSID of the WLAN access point every 30 seconds. I use it to track how
      much I'm procrastinating vs. working.
    - aptmanual: Saves all manually installed apt packages in a file so I can
      compare it on a new machine to see what packages I may need. This also
      contains packages which I did not install personally, but that's fine.
    - rlcone-sync@/rclone-mount@: Templates for syncing or mounting directories
      with rclone. See [/.config/rclone/README.md](/.config/rclone/README.md) for
      more details.

The rest of the units simple start programs of the same name on boot.
