#!/bin/bash

set -o pipefail

echo "Read the file"
cat my_file.txt

false | true

echo "Still printed even after failing "