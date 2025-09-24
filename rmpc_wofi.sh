#!/usr/bin/env bash
# Control Spotify via playerctl + wofi

# Define actions
actions="Play/Pause\nNext\nPrevious"

# Show menu in wofi
choice=$(echo -e "$actions" | wofi --dmenu -i --lines=4 --width=300 --prompt "rmpc control:")

# If user canceled
[ -z "$choice" ] && exit 0

case "$choice" in
  "Play/Pause") rmpc togglepause ;;
  "Next")       rmpc next ;;
  "Previous")   rmpc prev ;;
esac
