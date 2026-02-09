#!/usr/bin/env bash
cliphist list | cut -f2 | rofi -dmenu -p " clipboard" -matching fuzzy | wl-copy
