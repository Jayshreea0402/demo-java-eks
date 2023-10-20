# #!/bin/bash

# if [[ $(git diff --quiet) -ne 0 ]]; then
#     echo "Changes detected in Terraform templates."
#     exit 0
# else
#     echo "No changes in Terraform templates. Skipping Terraform deployment."
#     exit 1
# fi

!/bin/bash

# Define a flag for change detection
CHANGED=false

# List Terraform configuration file extensions
TF_EXTENSIONS= tf #(tf tfvars)

# Loop through Terraform files and check for changes
for EXTENSION in "${TF_EXTENSIONS[@]}"; do
    if git diff --quiet -- "path/to/your/terraform/files/*.$EXTENSION"; then
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
