## 🐚 scripts

shell scripts i use in my day-to-day workflow. they are written on a machine running arch and hyprland, keep that in mind when running elsewhere.

- `scripts.sh`: script launcher
  - color temperature: changes the display's color temperature to a selected preset
  - clipboard history: opens a list of clipboard history, copying the selected item
  - restart service: restarts services like waybar, dunst or hyprpaper
- battery notification: polls the battery and sends a notification if capacity is low
- [`notes.sh`](https://github.com/mellowcoffee/scripts/blob/main/notes/readme.md): a script for managing markdown notes
- backup: backs up files and directories

### usage

this segment assumes you use hyprland, but similar configuration is achievable on basically any window manager

clone the repo:
```sh
git clone https://github.com/mellowcoffee/scripts ~/scripts
```

create a keybinding for `scripts.sh` in your `hyprland.conf`:
```hyprlang
bind = SUPER, A, exec, $scripts
```

run `battery_notify.sh` on startup:
```hyprlang
exec-once = ~/scripts/battery_notify.sh
```

### customization

`dmenu`, or another compatible alternative may be used instead of `rofi` by just replacing every instance of `rofi -dmenu` within the scripts

`scripts.sh` exposes `restart_service.sh`, a quick way of restarting jobs such as `dunst` or `hyprpaper`. the script may be customized to include other services, or remove existing ones, by just editing the `SERVICES` map at the beginning of the file.

```bash
# ...
declare -A SERVICES
SERVICES=(
    ["  Your service"]="<executable>"
    ["  Waybar"]="waybar"
    ["  Dunst"]="dunst"
    ["󰸉  Hyprpaper"]="hyprpaper"
)
# ...
```

### notes

a dotfile repo that uses these shell scripts may be found [🧿 here](https://github.com/mellowcoffee/dots)
