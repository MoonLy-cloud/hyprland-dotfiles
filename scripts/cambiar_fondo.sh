#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers/"

while true; do
    # Wallpaper actual
    CURRENT_WALL=$(hyprctl hyprpaper listloaded)

    # Monitor enfocado
    FOCUSED_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')

    # Elige un wallpaper aleatorio distinto al actual
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

    # Aplica el wallpaper
    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload "$WALLPAPER"
    hyprctl hyprpaper wallpaper "$FOCUSED_MONITOR,$WALLPAPER"

    # Espera 2 minutos
    sleep 120
done

