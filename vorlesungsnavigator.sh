#!/bin/bash

projects=($(find ~/Vorlesungen -maxdepth 1 -mindepth 1 -type d -exec basename {} \;))

projects=(Vorlesungen "${projects[@]}")
target=$(gum filter "${projects[@]}")

if [ "$target" == "Vorlesungen" ]; then
    echo "cd ~/Vorlesungen/"
else
    echo "cd ~/Vorlesungen/$target"
fi

