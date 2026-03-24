#!/bin/bash

ACTIVE_PID=$(hyprctl activewindow -j | jq '.pid')

if [ -z "$ACTIVE_PID" ] || [ "$ACTIVE_PID" = "null" ]; then
	exit 1
fi

# Find node IDs matching the active PID
NODE_IDS=$(pw-dump | jq -r --argjson pid "$ACTIVE_PID" '
  .[] | select(
    .info.props["application.process.id"] == $pid and
    .info.props["media.class"] == "Stream/Output/Audio"
  ) | .id
')

if [ -z "$NODE_IDS" ]; then
	exit 1
fi

# Pick a sink with rofi
SINK=$(pw-dump | jq -r '
  .[] | select(.info.props["media.class"] == "Audio/Sink") 
  | .info.props["node.name"]
' | rofi -dmenu -p "Route audio to")

if [ -z "$SINK" ]; then exit 1; fi

# Get the sink's node ID
SINK_ID=$(pw-dump | jq -r --arg name "$SINK" '
  .[] | select(.info.props["node.name"] == $name) | .id
')

# Move each node
for NODE in $NODE_IDS; do
	pw-metadata "$NODE" target.object "$SINK_ID"
done
