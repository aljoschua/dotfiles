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

def execute_command(command):
    if isinstance(command, list):
        command = "\n".join(command)
    log("Executing {")
    print(command)
    log("}")
    if os.system(f"set -e\n{command}"):
        log(f"Command failed")
        exit()

def load_module(name):
    module = conf[name]
    log(f"Installing {name}...")
    if 'dep' in module:
        log(f"Installing requirements for {name}")
        for requirement in module['dep']:
            load_module(requirement)
        log(f"Installed requirements for {name}")

    if 'cmd' in module:
        execute_command(module['cmd'])
    log(f"Installed {name}")

load_module(cli_module)
