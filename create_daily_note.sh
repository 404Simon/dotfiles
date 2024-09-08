#!/bin/bash

vaultpath="/Users/simon/Library/Mobile Documents/iCloud~md~obsidian/Documents/SimonsVault"

# Get the current date in YYYY-MM-DD format
TODAY=$(date +"%Y-%m-%d")
FILE_PATH="$vaultpath/Journal/$TODAY.md"

# Template content to be injected into a new file
TEMPLATE="# Daily Note - $TODAY

## Tasks
- [ ] Task 1
- [ ] Task 2

## Notes
- Note 1
- Note 2

"

# Check if the file exists
if [ -f "$FILE_PATH" ]; then
    echo "File already exists. Opening $FILE_PATH..."
else
    echo "File does not exist. Creating $FILE_PATH..."
    echo "$TEMPLATE" > "$FILE_PATH"
fi

nvim "$FILE_PATH"
