#!/usr/bin/env bash
#
# preview_markdown.sh - launches an instant preview of a markdown file in zathura
# deps: pandoc, zathura

INFILE="$1"
[ ! -f "$INFILE" ] && { echo "Error: File not found."; exit 1; }
BASENAME=$(basename "${INFILE%.*}")
OUTFILE="/tmp/${BASENAME}.pdf"
pandoc "$INFILE" -o "$OUTFILE" && \
    (zathura "$OUTFILE" > /dev/null 2>&1 &)
