#!/bin/bash
set -euo pipefail
system_details(){
        echo "*********HOSTNAME AND OS**********"
        echo "The hostname of system is: $(hostname) "
        echo "The OS of the system is: $(uname -a)" 
}
print_uptime(){
        echo "************UPTIME****************"
        echo "The uptime of the system is: $(uptime)"

}
print_disk_usage(){
        echo "*************DISK USAGE***************"
        echo "The disk usage of the system is:"
        du -h --max-depth=1 2>/dev/null | sort -rh | head -n5
}
print_mem_usage(){
        echo "*****************MEMORY USAGE***********************"
        echo "The mem usage of the system is: $(free -h)"
}
print_top(){

        echo "*****************TOP***********************"
        echo "The top five processes are:"
         ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 6
}

main (){
system_details
print_uptime
print_disk_usage
print_mem_usage
print_top
}
 main