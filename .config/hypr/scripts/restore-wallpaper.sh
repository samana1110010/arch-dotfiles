#!/bin/bash
sleep 2
LAST=$(cat ~/.config/hypr/last-wallpaper 2>/dev/null)
[ -n "$LAST" ] && awww img "$LAST" --transition-type fade --transition-duration 1
