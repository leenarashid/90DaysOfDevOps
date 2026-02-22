#!/bin/bash

display_usage(){

echo "=======DISPLAYING USAGE============"
echo "Usage: ./backup.sh <path to the source> <path to the backup>"

}

source_dir=$1
backup_dir=$2
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')

if [ $# -ne 2 ]; then
  display_usage
  exit 1
fi

check_sources(){
if  [ ! -d  "$source_dir" ]; then
  echo "Source directory not found"
fi

if [ ! -d "$backup_dir" ]; then
   echo "Backup directory not found"
fi

}

create_backups(){

 tar -czf "${backup_dir}/backup_${timestamp}.tar.gz" "$source_dir" 2>/dev/null
 if [ $? -eq 0  ];then
  echo "backups have been archieved successfully"
fi

}
print_archive_details(){

 archive_details=($(ls -t "${backup_dir}/backup_"*.tar.gz 2>/dev/null))
 echo "${archive_details[@]}"
  

for file in "${archive_details[@]}"; do
  size=$(du -h "$file" | cut -f1)
  echo "Backup file: $file | Size: $size"
done
}

remove_old_backups(){



find "$backup_dir" -name "backup_*.tar.gz" -type f -mtime +14 | while read -r file; do
  echo "Deleting old backup: $file"
  rm -f "$file"
done

}



check_sources
create_backups
print_archive_details
remove_old_backups