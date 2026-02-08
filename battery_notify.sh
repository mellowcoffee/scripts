#!/bin/bash

THRESHOLD=20
CHECK_INTERVAL=60

while true; do
    BATTERY_PATH=$(ls /sys/class/power_supply/ | grep BAT | head -n 1)
    CAPACITY=$(cat "/sys/class/power_supply/$BATTERY_PATH/capacity")
    STATUS=$(cat "/sys/class/power_supply/$BATTERY_PATH/status")
    if [ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -le "$THRESHOLD" ]; then
        notify-send -u critical \
                    "  Low Battery" \
                    "Level: ${CAPACITY}%"
    fi
    sleep "$CHECK_INTERVAL"
done
