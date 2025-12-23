#!/usr/bin/env bash

# where Wayland runtime sockets live
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# detect Hyprland instance‐signature directory under $XDG_RUNTIME_DIR/hypr/
HIS=$(basename "$XDG_RUNTIME_DIR/hypr/"*)

# export so hyprctl can talk to running Hyprland
export HYPRLAND_INSTANCE_SIGNATURE="$HIS"

# export the Wayland display name
export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-0}"

WALLPAPER_DIR="/home/simon/dotfiles/wallpapers/matt.bower"

HOUR=$(date +%H)

if [ "$HOUR" -ge 20 ] || [ "$HOUR" -lt 5 ]; then
    SUBDIR="dark"
elif [ "$HOUR" -ge 17 ]; then
    SUBDIR="dusk"
else
    SUBDIR="light"
fi

WALLPAPER_SUBDIR="$WALLPAPER_DIR/$SUBDIR"

# Get current wallpaper
CURRENT_WALL=$(basename "$(hyprctl hyprpaper listloaded | awk 'NR==2 {print $2}')")

# Get random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_SUBDIR" -type f ! -name "$CURRENT_WALL" | shuf -n 1)

# Apply the selected wallpaper
if [ -n "$WALLPAPER" ]; then
    echo $WALLPAPER
    hyprctl hyprpaper reload ,"$WALLPAPER"
    /home/simon/.cargo/bin/thaimeleon "$WALLPAPER" -w ~/.config/yolk/chameleon.rhai
    /usr/bin/yolk sync

else
    echo "No wallpaper found in $WALLPAPER_SUBDIR (excluding current: $CURRENT_WALL)"
fi
