#!/bin/bash

# Get list of audio sinks with format "description (sink_name)"
sinks=$(pactl list short sinks | while read -r line; do
    sink_name=$(echo "$line" | cut -f2)
    description=$(pactl list sinks | grep -A 20 "Name: $sink_name" | grep "Description:" | cut -d: -f2- | sed 's/^ *//')
    echo "$description ($sink_name)"
done)

# Show rofi menu and get selection
selected=$(echo "$sinks" | rofi -dmenu -p "Select Audio Sink:")

# Exit if nothing selected
[ -z "$selected" ] && exit

# Extract sink name from selection (text between parentheses)
sink_name=$(echo "$selected" | sed 's/.*(\(.*\))/\1/')

# Set as default sink
pactl set-default-sink "$sink_name"

# Move all currently playing streams to new sink
pactl list short sink-inputs | cut -f1 | while read -r stream; do
    pactl move-sink-input "$stream" "$sink_name"
done
