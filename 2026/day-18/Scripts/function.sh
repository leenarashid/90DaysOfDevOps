#!/bin/bash


greet () {
read -p "Enter the naem: " name
echo "Hello! $name"
}

addition (){
read -p "Enter the first number: " first_num
read -p "Enter the second number" second_num

sum=$((first_num + second_num))
echo "The sum of two numbers is: $sum"

}