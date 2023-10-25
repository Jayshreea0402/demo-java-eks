# #!/bin/bash

# # Define a flag for change detection
# CHANGED=false

# # List Terraform configuration file extensions
# TF_EXTENSIONS='tf'

# # Loop through Terraform files and check for changes
# for EXTENSION in "${TF_EXTENSIONS[@]}"; do
#     if git diff --quiet -- "*.$EXTENSION"; then
#         echo "No changes detected in *.$EXTENSION files."
#     else
#         echo "Changes detected in *.$EXTENSION files."
#         CHANGED=true
#     fi
# done

# # Exit with status code indicating whether changes were detected
# if [ "$CHANGED" = true ]; then
#     exit 0  # Changes detected, exit with status code 1 (failure)
# else
#     exit 1  # No changes detected, exit with status code 0 (success)
# fi
