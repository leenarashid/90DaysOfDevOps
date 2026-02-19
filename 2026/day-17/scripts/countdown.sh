#!/bin/bash

read -p "Enter the number of your choice" num
if [ "$num" -gt 0 ]; then
        echo "Loop down to zero"
        while [ "$num" -ge 0 ]; do
           echo "$num"
           ((num--))
        done
        echo "DONE!!"
else
        echo "Enter the valid number"

fi
<<comment
Double () for decrement are important otherwise it will 
turn to infinite loop.
comment