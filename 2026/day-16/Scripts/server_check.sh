#!/bin/bash

read -p "Do you want to check the status of a service: " response

if [ "$response" == "yes"  ]; then

  read -p  "Which service you want to check the status of: " service_name

  service=("nginx" "sshd" "docker")

  for i in "${service[@]}";do
       if [ "$i" = "$service_name" ]; then

            sudo systemctl status $service_name
       fi

  done
elif [  "$response" == "no"   ]; then
       echo "No need to check the status"
       exit 0
else
        echo "Invalid response"

fi