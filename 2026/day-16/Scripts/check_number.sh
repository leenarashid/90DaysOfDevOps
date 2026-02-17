#!/bin/bash

read -p "Enter the number: " number

#Regex to check if the entry is apart from a number
if ! [[ "$number" =~  ^-?[0-9]+$ ]];then
        echo "Invalid:Please enter the number again!!"
        exit 1
fi

if [ "$number" -gt 0 ]; then
        echo "The entered numbber:$number is Positive"
elif [ "$number" -lt 0 ]; then
        echo "The entered number:$number is nagative"
elif [ "$number" -eq 0 ]; then
        echo "The entered number:$number is equal to zero"
fi