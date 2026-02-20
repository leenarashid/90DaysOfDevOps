#!/bin/bash

x=10
local_func(){
 echo "Print the value of x: $x"
 local x=20
 echo "Print the value of x: $x"
}
regular_func(){
echo "Print the value of x: $x"

 x=30           
echo "Print the value of x: $x"
}
local_func
regular_func
echo "Print the value of x: $x"