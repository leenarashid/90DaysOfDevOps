#!/bin/bash

packages=("docker.io" "nginx" "wget" "curl")

sudo apt-get update

for pkg in "${packages[@]}"; do
        echo "CHECK FOR THE PACKAGE: $pkg"

        if  dpkg -s "$pkg" &> /dev/null; then
                echo "ALREADY INSTALLED"

        else
             sudo apt install "$pkg" -y
             echo "PACKAGE $pkg HAS BEEN INSTALLED"
        fi
done