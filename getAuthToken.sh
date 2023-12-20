#!/bin/bash

auth_server_url="https://3f30-14-139-208-67.ngrok-free.app"

curl -s -X POST \
    -H "Content-Type: application/json" \
    -d '{
        "user_name":"test_agent",
        "role":"agent",
        "email":"aa@b.com",
        "password":"abcabc"
    }' \
    "${auth_server_url}/api/v1/user/getToken" | jq ".data.token" > .token