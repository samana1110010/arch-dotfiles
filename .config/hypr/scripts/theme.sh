#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper-thumbs"
mkdir -p "$CACHE_DIR"

# Generate thumbnails
for img in "$WALLPAPER_DIR"/*; do
    name=$(basename "$img")
    thumb="$CACHE_DIR/$name.png"
    if [ ! -f "$thumb" ]; then
        convert "$img" -resize 200x200^ -gravity center -extent 200x200 "$thumb"
    fi
done

# Show rofi with image previews
WALLPAPER=$(for img in "$WALLPAPER_DIR"/*; do
    name=$(basename "$img")
    thumb="$CACHE_DIR/$name.png"
    echo -en "$name\x00icon\x1f$thumb\n"
done | rofi -dmenu -p "" -show-icons -theme-str 'window {width: 800px;} listview {columns: 4; lines: 2;} element-text {enabled: false;} element-icon {size: 150px;}')

[ -z "$WALLPAPER" ] && exit

FULL_PATH="$WALLPAPER_DIR/$WALLPAPER"
awww img "$FULL_PATH" --transition-type fade --transition-duration 1
wallust run "$FULL_PATH" -T
