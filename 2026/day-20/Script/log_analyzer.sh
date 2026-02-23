#!/bin/bash
set -euo pipefail

display_usage() {
    if [ "$#" -ne 1 ]; then
        echo "USAGE: $0 <path to the logfile>"
        exit 1
    fi
}

log_file=$1

find_logfile() {
    if [ ! -f "$log_file" ]; then
        echo "No log file is found"
        exit 1
    fi
}

error_failed_count() {
    echo "=======Counting ERRORS==========="
    error_failed_number=$(grep -cE "ERROR|FAILED" "$log_file" || true)
    echo "$error_failed_number"
}

critical_count() {
    echo "==========Counting CRITICAL============="
    critical_lines=$(grep -ni "CRITICAL" "$log_file" || true)
    critical_number=$(echo "$critical_lines" | grep -c .)
    echo "The lines having 'CRITICAL' are:"
    echo "$critical_lines"
    echo "The total number of CRITICAL is: $critical_number"
}

top_errormsg_count() {
    echo "===========Counting ERROR MESSAGE==========="
    top_errormsg=$(grep "ERROR" "$log_file" | awk '{print $1,$2,$3}' | sort | uniq -c | sort -rn | head -5)
    echo "The count of top 5 error msgs is:"
    echo "$top_errormsg"
}

log_report() {
    log_report_file="log_report_$(date '+%Y-%m-%d').txt"
    today=$(date '+%Y-%m-%d')

    echo "The Log Report of $today is:" >> "$log_report_file"
    echo "The ERROR found is: $error_failed_number" >> "$log_report_file"
    echo "The total number of CRITICAL is: $critical_number" >> "$log_report_file"
    echo "Top 5 error messages:" >> "$log_report_file"
    echo "$top_errormsg" >> "$log_report_file"

    echo "Log report saved to $log_report_file"
}
archiving_report(){
    mkdir -p archive
    mv "$log_file_report" archive/
    echo "The report file has been archived"
}
# Run all
main() {
display_usage "$@"
find_logfile
error_failed_count
critical_count
top_errormsg_count
log_report
}