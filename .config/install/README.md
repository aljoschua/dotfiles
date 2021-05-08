# Install
This directory is dedicated to bootstrap a new system to my needs.
It installs and sets up programs by parsing a yaml file.
Note that I am on Linux Mint, and the steps below might not work for you.

#### How it works
```yaml
module1:
  dep: [module2]    # List of modules to be installed first
  cmd:              # Commands to be executed after
    - sudo usermod -aG plugdev $USER
    - |-
      echo "multiline
      command"
module2:
  unrelated-field:
    foo: bar
  cmd: 'echo installing: dependency of module1'
```
The install process basically executes shell commands in a structured manner.
The commands are defined in the `install.yml` file and ran by the `install.py` script.

A module is essentially a list of commands (cmd) and a list of dependencies (dep), which are other modules to be installed first.
Before calling `os.system(cmd)` in the python script, the command list is concatenated by newlines.
The rest of the magic you can find in the yaml file is actually just neat yaml syntax.

Note that each modules commands are executed in their own shell and are aborted, if one of them exits with a non-zero exit code (due to the `set -e` in the python script).
