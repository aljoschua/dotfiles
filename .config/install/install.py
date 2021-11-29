#!/usr/bin/env python3

import yaml
import os, sys

if len(sys.argv) > 1:
    cli_module = sys.argv[1]
else:
    cli_module = "default"

config_file = "/".join(__file__.split('/')[:-1]) + "/install.yml"
conf = yaml.load(open(config_file), Loader=yaml.SafeLoader)

def log(string):
    print(f"\x1b[1;31m### {string}\x1b[0m")

def execute_commands(commands):
    if isinstance(commands, list):
        commands = "\n".join(commands)
    log("Executing {")
    print(commands)
    log("}")
    if os.system(f"set -e\n{commands}"):
        log(f"Commands failed")
        exit()

def install_module(name):
    module = conf[name]
    log(f"Installing {name}...")

    if 'dep' in module:
        log(f"Installing dependency for {name}")
        for dependency in module['dep']:
            install_module(dependency)
        log(f"Installed dependency for {name}")

    if 'cmd' in module:
        execute_commands(module['cmd'])
    log(f"Installed {name}")

install_module(cli_module)
