#! /usr/bin/env bash

boxes=$(
	jq -rn \
		--argjson monitors "$(hyprctl -j monitors)" \
		--argjson clients "$(hyprctl -j clients)" \
		'
		($monitors | map(.activeWorkspace.id)) as $active
		| $clients[]
		| select(.workspace.id | IN($active[]))
		| "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"
		'
)

grim -g "$(slurp <<<"$boxes")" - \
	| satty --floating-hack \
		--actions-on-escape save-to-clipboard,exit \
		--copy-command wl-copy \
		-f -
