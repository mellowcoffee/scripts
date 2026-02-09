#!/usr/bin/env bash

source "$HOME/scripts/.env"

declare -A TEMPS
TEMPS=(
    [" Daylight (6500K)"]="6500"
    [" Office (5000K)"]="5000"
    [" Golden Hour (4500K)"]="4500"
    [" Evening (3500K)"]="3500"
    ["󰽢 Night (2500K)"]="2500"
)

LIST=$(for key in "${!TEMPS[@]}"; do
    echo "${TEMPS[$key]} $key"
done | sort -rn | cut -d' ' -f2-)

CHOICE=$(echo -e "$LIST" | rofi -dmenu -i -p "$TEMPERATURE_ICON temp" -no-custom -l 5)

if [[ -n "$CHOICE" ]]; then
    VALUE=${TEMPS[$CHOICE]}
    pkill wlsunset
    wlsunset -t "$VALUE" &
    notify-send "$SCRIPTS_TITLE" "$TEMPERATURE_ICON  Temperature set to ${VALUE}K" -a "$TEMPERATURE_NAME"
fi
