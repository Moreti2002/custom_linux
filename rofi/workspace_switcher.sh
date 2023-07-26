#!/bin/bash

workspaces=$(swaymsg -t get_workspaces | jq -r '.[] | .name')
chosen_workspace=$(echo -e "$workspaces" | rofi -dmenu -i -p "Switch to workspace:")

if [ -n "$chosen_workspace" ]; then
    swaymsg "workspace $chosen_workspace"
fi

