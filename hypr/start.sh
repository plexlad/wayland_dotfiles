#!/usr/bin/env bash

# initializing
swww init &
# Setting wallpaper
swww img ~/.config/wallpapers/anime/classroom.jpg &

nm-applet --indicator &

# bar
waybar &
