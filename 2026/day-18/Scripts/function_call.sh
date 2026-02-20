#!/bin/bash

source ./function.sh
read -p "Which function do you want to call: " answer

if [ "$answer" = "First" ];then
  echo "Calling greet function from the script function"
  greet
elif [ "$answer" = "Second" ]; then

  echo "Calling addition function from the script  function"
  addition
elif [ "$answer" = "Both" ]; then
        echo "Calling both the functions from the script function"
        greet
        addition
else
     echo "pass"
fi