# Install
This directory is dedicated to bootstrap a new system to my needs.
It installs and sets up programs by executing idempotent shell functions.
Note that I am on Linux Mint, and the install steps might not apply for your system.

#### How it works
The install process executes shell functions which in turn call other functions.
The functions are defined in the `install.sh` file.
`_require` for example interprets its arguments as shell functions and executes them. It tracks which functions were called with the parameter `stacktrace` which makes finding errors easier.

Conveniently, this script has zero dependencies (since it installs this
repository if it isn't already), meaning one can download the script and pipe it
into `sh` to install everything:

```bash
$ wget -O- raw.githubusercontent.com/aljoschua/dotfiles/main/.config/install/install.sh | sh
or
$ curl -L raw.githubusercontent.com/aljoschua/dotfiles/main/.config/install/install.sh | sh
```

On a new system, you wouldn't want to type this long URL in manually, so I
shortened it to `rb.gy/g7akux`.

Additionally, you could theoretically supply arguments to the script with `sh -s
terminal`, which would install and setup the terminal applications I use.

