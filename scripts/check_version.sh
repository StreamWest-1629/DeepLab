#!/bin/sh
echo go version: $(python3 --version)
echo python packages...
python3 -m pip list --format columns
