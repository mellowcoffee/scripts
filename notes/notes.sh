#!/usr/bin/env bash
#              __        
#   ___  ___  / /____ ___
#  / _ \/ _ \/ __/ -_|_-<
# /_//_/\___/\__/\__/___/.sh
# a script for managing markdown notes
# 
# dependencies: rofi, ripgrep, fd

terminal="foot"
editor="nvim"
folder="${HOME}/notes"
menu="rofi -dmenu -i -matching fuzzy -sort -sorting-method fzf -p"

icon_notes="󰎚"
icon_open=""
icon_new=""
icon_tags=""
icon_grep=""

command -v rofi >/dev/null 2>&1 || { echo >&2 "ERROR: rofi required."; exit 1; }
command -v rg >/dev/null 2>&1 || { echo >&2 "ERROR: ripgrep (rg) required."; exit 1; }
command -v fd >/dev/null 2>&1 || { echo >&2 "ERROR: fd required."; exit 1; }

open_file() {
    [[ -f "$1" ]] && setsid -f "$terminal" -e "$editor" "$1" && exit 0
}

# open existing note
action_open() {
    file=$(fd --type file --glob "*.md" "$folder" | sed "s|$folder/||" | $menu "$icon_open Open")
    [[ -n "$file" ]] && open_file "$folder/$file"
}

# create new note
action_new() {
    title=$(echo "" | $menu "$icon_new Title" -l 0)
    [[ -z "$title" ]] && exit 0
    
    clean_title=$(echo "$title" | tr ' ' '_')
    filepath="$folder/${clean_title}.md"
    
    if [[ ! -f "$filepath" ]]; then
        printf -- "---\ntags: \ntitle: %s\ndate: %s\n---\n\n" "$title" "$(date -Iseconds)" > "$filepath"
    fi
    open_file "$filepath"
}

# search tags, then notes of selected tag
action_tags() {
    # extract body tags: #[tag]
    # extract frontmatter: tags: a, b
    tags=$( {
        rg -o "#[a-zA-Z0-9_-]+" "$folder" --no-filename | sed -e 's/#//g'
        rg "^tags:.*" "$folder" --no-filename | sed -e 's/tags://g' -e 's/,/ /g'
    } | tr ' ' '\n' | sed '/^$/d' | sort -u | $menu "$icon_tags Tags")
    
    [[ -z "$tags" ]] && exit 0

    pattern="(#${tags}\b|^tags:.*\b${tags}\b)"
    
    file=$(rg -l "$pattern" "$folder" | sed "s|$folder/||" | $menu "$icon_tags Matches")
    [[ -n "$file" ]] && open_file "$folder/$file"
}

# full text search
action_grep() {
    selection=$(rg --line-number "." "$folder" | sed "s|$folder/||" | $menu "$icon_grep Find" -theme-str 'window {width:50%;}')
    [[ -z "$selection" ]] && exit 0
    
    file=$(echo "$selection" | cut -d':' -f1)
    line=$(echo "$selection" | cut -d':' -f2)
    
    setsid -f "$terminal" "$editor" "+$line" "$folder/$file"
}

main() {
    choice=$(printf "%s Open\n%s New\n%s Tags\n%s Grep" "$icon_open" "$icon_new" "$icon_tags" "$icon_grep" | \
             $menu "$icon_notes Notes" -l 4 | awk '{print $2}')
    
    case "$choice" in
        "Open") action_open ;;
        "New")  action_new ;;
        "Tags") action_tags ;;
        "Grep") action_grep ;;
        *)      exit 1 ;;
    esac
}

main
