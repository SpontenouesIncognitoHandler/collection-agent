#!/bin/bash

journalctl -f -p "notice".."debug" -o json >> logfile.txt