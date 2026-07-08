#!/usr/bin/env bash
#
# deps: cliphist, rofi, wl-copy

cliphist list | cut -f2 | rofi -dmenu -p " clipboard" -matching fuzzy | wl-copy
