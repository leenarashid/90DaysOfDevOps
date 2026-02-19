#!/bin/bash
i=1
for city in "$@"
do
    echo "The $i entered arg is: $city"
    ((i++))
done
echo "total number is: $#"
echo "print all args: $@"



