#!/usr/bin/env bash

INFILE="$1"
[ ! -f "$INFILE" ] && { echo "Error: File not found."; exit 1; }
BASENAME=$(basename "${INFILE%.*}")
OUTFILE="/tmp/${BASENAME}.pdf"
pandoc "$INFILE" -o "$OUTFILE" && \
    (zathura "$OUTFILE" > /dev/null 2>&1 &)
