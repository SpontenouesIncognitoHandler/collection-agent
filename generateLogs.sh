#!/bin/bash

source_log="Hadoop_2k.log"
destination_log="logfile.txt"

rm "$destination_log"
touch "$destination_log"

# rm -r last_sent_lines/

interval=1

while true; do
    while IFS= read -r line; do
        echo "$line" >> "$destination_log"
        sleep "$interval"
    done < "$source_log"
    sleep "$interval"
done
