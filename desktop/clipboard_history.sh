#!/usr/bin/env bash
# clipboard_history.sh - opens a list of clipboard history, copying the selected item
# deps: cliphist, rofi, wl-copy

cliphist list | cut -f2 | rofi -dmenu -p " clipboard" -matching fuzzy | wl-copy
