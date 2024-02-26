#!/usr/bin/env bash

# initializing
swww init &
# Setting wallpaper
swww img ~/Downloads/comfypunk_wallpaper.gif &

nm-applet --indicator &

# bar
waybar &
