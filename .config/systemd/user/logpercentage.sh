#!/usr/bin/env bash

upower -d | awk '$1 == "percentage:" {print $2; exit}'
