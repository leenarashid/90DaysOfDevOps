#!/bin/bash

<<comment
This is a simple for-loop script.
It will iterate thrugh the array and gives output one by one
comment
fruits=("apple" "banana" "grapes" "pineapple" "kiwi")

for fruit in "${fruits[@]}";do
        echo "$fruit"
done
<<comment
If we do fruits=("apple","banana","orange")
WITH commas added it will print the whle array at the same time
comment