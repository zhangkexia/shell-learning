#!/bin/bash
#filename: watchdir.sh
#usage: dir mon
path=$1
#dir name or path as para

inotifywait -m -r -e create,move,delete $path -q

