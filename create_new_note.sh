#!/bin/bash

function new_obsidian_note() {
    articlename=$(gum input --placeholder="My Awesome Note" --prompt="> Title: ")
    filename=${articlename// /_}.md
    filename=$(echo "$filename" | sed -e 's/ä/ae/g' -e 's/ö/oe/g' -e 's/ü/ue/g' -e 's/ß/ss/g' -e 's/Ä/Ae/g' -e 's/Ö/Oe/g' -e 's/Ü/Ue/g')
    if [ -z "$articlename" ]; then
        echo "No title provided, exiting..."
        exit 1
    fi
    targetpath="$OBSIDIAN_VAULT/$filename"

    if [ -f "$targetpath" ]; then
       echo "Filename already exists, please try again!"
       new_obsidian_note
    else
        echo -e "# $articlename\n\n" > "$targetpath"
        echo $targetpath
        return 0
        # nvim +3 "$targetpath"
    fi
}

new_obsidian_note
