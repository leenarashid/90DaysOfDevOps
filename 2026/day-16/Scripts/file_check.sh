#!/bin/bash

read -p "Enter the filename: " file_name

if [[ "$file_name" =~ [@%#^:] ]]; then
        echo "Invalid"
        exit 1
fi



if  [ -f "$file_name" ]; then
        echo "File is present"
else
        echo "File is not present"
fi