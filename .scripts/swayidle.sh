#!/bin/sh
swayidle -w timeout 300 'swaylock -f -i ~/.wallpaper.png' timeout 600 'niri msg action power-off-monitors' before-sleep 'swaylock -f -i ~/.wallpapers/uta.png'

