#!/bin/sh
echo $(goofys --version)
echo python packages...
python3 -m pip list --format columns
