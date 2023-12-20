#!/bin/bash

logline=$(journalctl -q -r -n 1)
echo "$logline"
python encrypt.py '"'"$logline"'"'