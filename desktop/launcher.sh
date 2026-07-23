#!/usr/bin/env bash
# launcher.sh - rofi hub for launching scripts
# deps: rofi, notify-send, nerd font

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/.env"

declare -A HUB
HUB=(
    ["$TEMPERATURE_TITLE"]="$SCRIPT_DIR/color_temperature.sh"
    ["$RESTART_TITLE"]="$SCRIPT_DIR/restart_service.sh"
    ["$CLIPBOARD_TITLE"]="$SCRIPT_DIR/clipboard_history.sh"
    ["$EXIT_TITLE"]="$SCRIPT_DIR/exit_hyprland.sh"
)

LIST=$(printf "%s\n" "${!HUB[@]}" | sort)

CHOICE=$(echo -e "$LIST" | rofi -dmenu -i -p "$SCRIPTS_ICON scripts" -l "${#HUB[@]}" -no-custom -matching fuzzy)

if [[ -n "$CHOICE" ]]; then
    SCRIPT_PATH="${HUB[$CHOICE]}"
    if [[ -x "$SCRIPT_PATH" ]]; then
        bash "$SCRIPT_PATH" &
    else
        notify-send "$SCRIPTS_TITLE" "Script not found or not executable at $SCRIPT_PATH" -a "Error"
    fi
fi
