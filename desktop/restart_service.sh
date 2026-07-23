#!/usr/bin/env bash

source "$HOME/scripts/env.sh"

declare -A SERVICES
SERVICES=(
    ["  Waybar"]="waybar"
    ["  Dunst"]="dunst"
    ["󰸉  Hyprpaper"]="hyprpaper"
)

LIST=$(printf "%s\n" "${!SERVICES[@]}" | sort)

CHOICE=$(echo -e "$LIST" | rofi -dmenu -i -p "$RESTART_ICON restart" -l "${#SERVICES[@]}" -no-custom)

if [[ -n "$CHOICE" ]]; then
    BINARY=${SERVICES[$CHOICE]}
    killall -q "$BINARY"
    sleep 0.5
    $BINARY &
    notify-send "$SCRIPTS_TITLE" "$RESTART_ICON  Restarted service $BINARY" -a "$RESTART_NAME"
fi
