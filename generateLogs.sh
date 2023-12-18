#!/bin/bash

source_log="Linux_2k.log"
destination_log="logfile.txt"

touch "$destination_log"

interval=1

while true; do
    while IFS= read -r line; do
        echo "$line" >> "$destination_log"
        sleep "$interval"
    done < "$source_log"
    sleep "$interval"
done
