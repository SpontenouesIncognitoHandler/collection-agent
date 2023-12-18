#!/bin/bash

log_files=(
    "logfile.txt"
    #...
)

server_url=""
marker_directory="last_sent_lines"
threshold=10
collection_interval=1

function get_last_sent_line {
    local log_file=$1
    local marker_file="$marker_directory/$(basename "$log_file")_last_sent_line.txt"

    if [ -f "$marker_file" ]; then
        cat "$marker_file"
    else
        echo "0"
    fi
}

function update_last_sent_line {
    local log_file=$1
    local marker_file="$marker_directory/$(basename "$log_file")_last_sent_line.txt"

    echo "$2" > "$marker_file"
}

function read_new_logs {
    for log_file in "${log_files[@]}"; do
        local last_sent_line
        last_sent_line=$(get_last_sent_line "$log_file")

        tail -n +"$((last_sent_line + 1))" "$log_file"
    done
}

function send_logs_to_server {
    for log_file in "${log_files[@]}"; do
        local last_sent_line
        last_sent_line=$(get_last_sent_line "$log_file")

        local current_line
        current_line=$(wc -l < "$log_file")

        local new_logs_count
        new_logs_count=$((current_line - last_sent_line))

        if [ "$new_logs_count" -ge "$threshold" ]; then
            local new_logs
            new_logs=$(tail -n +"$((last_sent_line + 1))" "$log_file")

            if [ -n "$new_logs" ]; then
                # curl -X POST -d "$new_logs" "$server_url"
                
                if [ $? -eq 0 ]; then
                    echo "Logs from '$log_file' sent successfully"
                    echo "$new_logs"
                    update_last_sent_line "$log_file" "$current_line"
                else
                    echo "Failed to send logs from '$log_file'. Curl command exited with a non-zero status."
                fi
            else
                echo "No new logs to send from '$log_file'."
            fi
        else
            echo "Threshold not reached for '$log_file'. No new logs will be sent."
        fi
    done
}

mkdir -p "$marker_directory"

while true; do
    send_logs_to_server
    sleep "$collection_interval"
done
