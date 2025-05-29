mkdir -p /tmp/hyprlock
grim -g "0,0 1920x1080" - >/tmp/hyprlock/base.png

./regen-bg.sh
