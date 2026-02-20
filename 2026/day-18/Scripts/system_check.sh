#!/bin/bash

source ./disk_check.sh
echo "******Calling disk function******"
check_disk

echo "******Calling memory function******"
check_mem
