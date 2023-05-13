#!/bin/bash

# Get the current directory
current_dir=$(pwd)

# Get a list of all subfolders, excluding hidden folders
subfolders=$(find . -type d ! -path "*/.*")

# For each subfolder, run terraform fmt
for subfolder in $subfolders; do
  echo "Running terraform fmt on $subfolder"
  cd $subfolder
  terraform fmt
  cd $current_dir
done
