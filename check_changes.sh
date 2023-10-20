#!/bin/bash

# Define a flag for change detection
CHANGED=false

# List Terraform configuration file extensions
TF_EXTENSIONS= (tf) #(tf tfvars)

# Loop through Terraform files and check for changes
for EXTENSION in "${TF_EXTENSIONS[@]}"; do
    if git diff --quiet -- "*.$EXTENSION"; then
        echo "No changes detected in *.$EXTENSION files."
    else
        echo "Changes detected in *.$EXTENSION files."
        CHANGED=true
    fi
done

# Exit with status code indicating whether changes were detected
if [ "$CHANGED" = true ]; then
    exit 0
else
    exit 1
fi
