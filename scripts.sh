#!/usr/bin/env bash
#                   __         __                   __    
# .-----.----.----.|__|.-----.|  |_.-----.  .-----.|  |--.
# |__ --|  __|   _||  ||  _  ||   _|__ --|__|__ --||     |
# |_____|____|__|  |__||   __||____|_____|__|_____||__|__|
#         rofi hub for |__| launching scripts             
# deps:
# * global: rofi, notify-send, nerd font
# * color temperature: wlsunset
# * clipboard history: wl-clipboard, cliphist

source "$HOME/scripts/.env"
SCRIPT_DIR="$HOME/scripts"

declare -A HUB
HUB=(
    ["$TEMPERATURE_TITLE"]="$SCRIPT_DIR/color_temperature.sh"
    ["$RESTART_TITLE"]="$SCRIPT_DIR/restart_service.sh"
    ["$CLIPBOARD_TITLE"]="$SCRIPT_DIR/clipboard_history.sh"
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
