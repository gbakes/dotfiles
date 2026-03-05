#!/bin/bash
# Close all windows except the currently focused one

# Get the current window address
current=$(hyprctl activewindow -j | jq -r '.address')

# Get all window addresses in the current workspace
windows=$(hyprctl clients -j | jq -r '.[] | select(.workspace.id == '$(hyprctl activeworkspace -j | jq -r '.id')') | .address')

# Close all windows except the current one
for window in $windows; do
    if [ "$window" != "$current" ]; then
        hyprctl dispatch closewindow address:$window
    fi
done
