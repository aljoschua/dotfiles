#!/usr/bin/env python3

import yaml
import argparse
import os
import logging, coloredlogs
import pathlib

parser = argparse.ArgumentParser(description='Install stuff from yaml file.')
parser.add_argument('module', default='default', nargs='?',
        help='The target module to install')
parser.add_argument('--list', '-l', action='store_true')
args = parser.parse_args()

coloredlogs.install()
config_file = pathlib.Path(__file__).parent / 'install.yml'
conf = yaml.load(open(config_file), Loader=yaml.SafeLoader)
if args.list:
    print(conf.keys())
    exit()

def execute_command(command):
    if isinstance(command, list):
        command = "\n".join(command)
    logging.info("Executing {")
    print(command)
    logging.info("}")
    if os.system(f"set -e\n{command}"):
        logging.error(f"Command failed")
        exit()

def load_module(name):
    module = conf[name]
    logging.info(f"Installing {name}...")
    if 'dep' in module:
        logging.info(f"Installing requirements for {name}")
        for requirement in module['dep']:
            load_module(requirement)
        logging.info(f"Installed requirements for {name}")

    if 'cmd' in module:
        execute_command(module['cmd'])
    logging.info(f"Installed {name}")

load_module(args.module)
