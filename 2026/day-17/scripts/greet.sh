#!/bin/bash

echo "Enter the name $1"
if [ $# -eq 0  ]; then
        echo "In-valid input"
        echo "Usage:./greet.sh <name>"
else
    echo "The entered name is : $1"     
fi

