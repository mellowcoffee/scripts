## desktop scripts

a collection of various scripts that enhance user experience on wayland
window managers. some scripts are hyprland-specific.

### launcher

`launcher.sh` opens a rofi picker of the following scripts:
- color temperature: changes the display's color temperature to a selected preset
- clipboard history: opens a list of clipboard history, copying the selected item
- restart service: restarts services like waybar, dunst or hyprpaper
- exit hyprland: exits hyprland. duh.

create a hyprland keybinding to open the launcher:
```hyprlang
$scripts = /home/username/scripts
bind = SUPER, A, exec, $scripts/desktop/launcher.sh
```

### battery notifications

`battery_notify.sh` polls the battery and sends a notification if charge is
below a given threshold

run `battery_notify.sh` on startup:
```hyprlang
exec-once = ~/scripts/desktop/battery_notify.sh
```

### customization

`dmenu`, or another compatible alternative may be used instead of `rofi` by
just replacing every instance of `rofi -dmenu` within the scripts

`scripts.sh` exposes `restart_service.sh`, a quick way of restarting jobs
such as `dunst` or `hyprpaper`. the script may be customized to include other
services, or remove existing ones, by just editing the `SERVICES` map at the
beginning of the file.

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
