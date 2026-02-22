#!/bin/bash

display_usage(){
echo "Usage: ./log_rotate.sh <path to the source> <path to the directory>"
echo "Please follow the right way"

}

dir=$1
compressed_files=0
deleted_files=0


find_directory(){

if [ -z "$dir" ]; then
    display_usage
    exit 1
fi


if [ ! -d "$dir" ]; then
        echo "Not Found"
        exit 1

fi 

}

compress_files() {

    echo "Compressing files older than 7 days..."

    compressed_files=0

    for file in $(find "$dir" -type f -name "*.log" -mtime +7); do
        gzip "$file"
        ((compressed_files++))
    done

    echo "Number of files compressed older than 7 days is : $compressed_files"
}

delete_files(){
deleted_files=0
echo "Deleting files older than 30 days"
for file in $(find "$dir"  -type f -name *.gz* -mtime +30); do
        rm "$file"
        ((deleted_files++))
done
echo "Number of deleted files older than 30 days is: $deleted_files"

}


find_directory
compress_files
delete_files