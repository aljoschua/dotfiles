#!/usr/bin/env python3

import yaml
import argparse
import os
import logging, coloredlogs
import pathlib

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('module', default='default', nargs='?',
        help='The target module to install')
parser.add_argument('--list', '-l', action='store_true')
parser.add_argument('--echo', '-e', action='store_true')
# add -s/--skip option for modules
args = parser.parse_args()

coloredlogs.install()
config_file = pathlib.Path(__file__).parent / 'install.yml'
conf = yaml.load(open(config_file), Loader=yaml.SafeLoader)
if args.list:
    print(conf.keys())
    exit()

def execute_command(command):
    if args.echo:
        print(f"$ {command}")
    return_code = os.system(command) # doesn't work for cd
    if return_code:
        logging.error(f"{command} failed with exit code {return_code}")
        exit()

def module_commands(key, dict):
    if key in dict:
        for command in dict[key]:
            execute_command(command)

def load_module(name):
    module = conf[name]
    logging.info(f"Installing {name}...")
    if 'requires' in module:
        logging.info(f"Installing requirements for {name}")
        for requirement in module['requires']:
            load_module(requirement)
        logging.info(f"Installed requirements for {name}")

    module_commands('before', module)

    if 'packages' in module:
        execute_command("sudo apt-get -y install " +
                module['packages'].__str__()[1:-1].replace(',', ' '))

    if 'git' in module:
        execute_command(f"git clone {module['git']['url']} tmp")
        execute_command(f"cd tmp")

        module_commands('commands', module['git'])

        execute_command(f"cd ..")
        execute_command(f"rm -rf tmp")

    module_commands('after', module)
    logging.info(f"Installed {name}")

load_module(args.module)
