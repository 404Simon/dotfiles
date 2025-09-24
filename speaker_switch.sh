#!/usr/bin/env bash

sinks=$(wpctl status | awk '/Sinks:/{flag=1;next}/Sources:/{flag=0}flag' \
  | sed 's/^[^0-9]*//')

choice=$(echo "$sinks" | wofi --dmenu -i -p "Choose audio output:")

[ -z "$choice" ] && exit 0

sink_id=$(echo "$choice" | awk '{print $1}' | tr -d '.')
wpctl set-default "$sink_id"
