#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root"
    exit 1
fi
packages=("nginx" "docker.io" "wget" "curl")
echo "Updating the package"
apt-get update
for pkg in "${packages[@]}"; do
        if dpkg -s "$pkg" &> /dev/null; then
                echo "****$pkg****** has been installed already"
        else
            echo "INSTALL THE PACKAGE"
            sudo apt install $pkg -y
            echo "SUCCESSFULLY INSTALLED $pkg"
            echo "************ "$pkg" *********************"  
                fi
done