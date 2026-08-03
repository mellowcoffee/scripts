#!/usr/bin/env bash
# ghostty_font.sh - change ghostty's font
set -euo pipefail

conf="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
dir=$conf/fonts
target=$conf/font.conf

[[ -d $dir ]] || { echo "no $dir" >&2; exit 1; }

name=$(find "$dir" -maxdepth 1 -name '*.conf' -printf '%f\n' \
  | sed 's/\.conf$//' | sort \
  | fzf --layout=reverse --height=20% --border=sharp --border-label=" Choose a font " --prompt="$ " --info=hidden --separator=" " --cycle \
)|| exit 0

ln -sfr "$dir/$name.conf" "$target"
echo -e "\033[1m=> Changed Ghostty's font to \033[1;36m$name\033[0m."
