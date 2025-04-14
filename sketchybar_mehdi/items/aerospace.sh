#!/bin/bash

aerospace=(
    icon.width=0
    label.width=0
    script="$PLUGIN_DIR/aerospace.sh"
    icon.font="$FONT:Bold:16.0"
    associated_display=active
)
sketchybar --add event aerospace_window_focus \
    --add event aerospace_windows_on_spaces \
    --add item aerospace left \
    --set aerospace "${aerospace[@]}" \
    --subscribe aerospace aerospace_window_focus \
    aerospace_space_change \
    aerospace_windows_on_spaces \
    mouse.scrolled.global \
    mouse.clicked
