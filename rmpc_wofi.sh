#!/usr/bin/env bash

# Define actions
actions="Next\nPrevious"

# Show menu in wofi
choice=$(echo -e "$actions" | wofi --dmenu -i --lines=3 --width=300 --prompt "rmpc control:")

# If user canceled
[ -z "$choice" ] && exit 0

case "$choice" in
  "Next")       /home/simon/dev/rmpc/target/release/rmpc next ;;
  "Previous")   /home/simon/dev/rmpc/target/release/rmpc prev ;;
esac
