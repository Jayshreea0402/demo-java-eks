#!/bin/bash

if [[ $(git diff --quiet) -ne 0 ]]; then
    echo "Changes detected in Terraform templates."
    exit 0
else
    echo "No changes in Terraform templates. Skipping Terraform deployment."
    exit 1
fi
