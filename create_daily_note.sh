#!/bin/bash

# Get the current date in YYYY-MM-DD format
TODAY=$(date +"%Y-%m-%d")
FILE_PATH="$OBSIDIAN_VAULT/Journal/$TODAY.md"

# Template content to be injected into a new file
TEMPLATE="# Daily Note - $TODAY

[[Daily_Notes]]



"

# Check if the file exists
if [ -f "$FILE_PATH" ]; then
    echo "File already exists. Opening it now!"
else
    echo "File does not exist. Creating a new one!"
    echo "$TEMPLATE" > "$FILE_PATH"
fi

# nvim +5 "$FILE_PATH"
