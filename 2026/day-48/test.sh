#!/bin/bash

# Simple test script to hit the health endpoint
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8000/health)

if [ "$response" -eq 200 ]; then
    echo -e "\e[32mTest passed! Status: 200 OK\e[0m"
    echo "Response: $(curl -s http://localhost:8000/health)"
    exit 0
else
    echo -e "\e[31mTest failed! Status: $response\e[0m"
    exit 1
fi
