#!/usr/bin/env bash

source "$HOME/scripts/.env"
SCRIPT_DIR="$HOME/scripts"

declare -A HUB
HUB=(
    ["$TEMPERATURE_TITLE"]="$SCRIPT_DIR/color_temperature.sh"
    ["$RESTART_TITLE"]="$SCRIPT_DIR/restart_service.sh"
)

LIST=$(printf "%s\n" "${!HUB[@]}" | sort)

CHOICE=$(echo -e "$LIST" | rofi -dmenu -i -p "scripts" -no-custom)

if [[ -n "$CHOICE" ]]; then
    SCRIPT_PATH="${HUB[$CHOICE]}"
    if [[ -x "$SCRIPT_PATH" ]]; then
        bash "$SCRIPT_PATH" &
    else
        notify-send "$SCRIPTS_TITLE" "Script not found or not executable at $SCRIPT_PATH" -a "Error"
    fi
fi
