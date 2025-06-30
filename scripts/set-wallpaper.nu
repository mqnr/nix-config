#!/usr/bin/env nu

let dir = $env.HOME | path join "Pictures" "Wallpapers"

let choice = glob $"($dir)/**/*" --no-dir
  | path relative-to $dir
  | to text
  | wofi --dmenu --sort-order alphabetical --prompt "Choose a wallpaper..."

swww img ($dir | path join $choice) --transition-type right --transition-duration 1
