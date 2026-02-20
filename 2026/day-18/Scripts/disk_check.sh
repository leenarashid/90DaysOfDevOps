#!/bin/bash

check_disk () {
echo "Checking the disk usage" 
df -h | awk '{print $1, $3, $4,$5 }'
}

check_mem () {

echo "Checking the memory"
free -h | awk '{print $1, $2, $3 ,$4}'


}