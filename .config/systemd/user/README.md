# Systemd Units

These are my systemd units, pieces of code that regularly execute on my machine, either explicitly by me or in an automated manor.
I use systemd.timer(5) instead of cron(8) and I start graphical programs on boot with sysd as well (via the graphical.target I created).
