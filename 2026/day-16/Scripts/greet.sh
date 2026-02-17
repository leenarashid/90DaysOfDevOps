#!/bin/bash

<<comment
Taking input from the user.
comment

read -p "Please enter your first  name: " f_name
read -p "Pleasse enter your last name: " l_name
read -p "Which one is your favourite DevOps tool: " dev_tool

#Capitalizing the first letter of each word

f_name=${f_name^}
l_name=${l_name^}
dev_tool=${dev_tool^}

echo "Hello my name is $f_name $l_name, and I like to work with $dev_tool"