#!/bin/bash

set -e

mkdir /tmp/devops-test && echo "My directory has been created" || { echo "Already exists"; echo "Do you want to work with it"; }

<<comment
the above case works for mkdir but with touch it doesnt work
comment
