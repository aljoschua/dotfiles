# Install
This directory is dedicated to bootstrap a new system to my needs.
It installs and sets up programs by executing idempotent shell functions.
Note that I am on Linux Mint, and the steps below might not work for you.

#### How it works
The install process basically executes shell functions in a structured manner.
The functions are defined in the `install.sh` file.

`_require` for example interprets its arguments as shell functions and executes them. It tracks which functions were called with the parameter `stacktrace` which makes finding errors easier.
