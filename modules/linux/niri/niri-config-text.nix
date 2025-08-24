{ config, lib, ... }:

let
  baseConfig = ''
    input {
        keyboard {
            xkb {
                layout "tangent-gallium"
                model ""
                rules ""
                variant ""
            }
            repeat-delay 600
            repeat-rate 25
            track-layout "global"
        }
        touchpad {
            tap
            dwt
            natural-scroll
        }
        mouse { accel-profile "flat"; }
    }
    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
    prefer-no-csd
    layout {
        gaps 8
        struts {
            left 0
            right 0
            top 0
            bottom 0
        }
        focus-ring {
            width 2
            urgent-color "#e57380"
            active-color "#73b8e5"
        }
        border { off; }
        default-column-width
        center-focused-column "never"
    }
    cursor {
        xcursor-theme "default"
        xcursor-size 24
    }
    environment {
        DISPLAY ":0"
        "_JAVA_AWT_WM_NONREPARENTING" "1"
    }
    binds {
        Alt+F3 { spawn "fuzzel"; }
        Alt+F4 { close-window; }
        Alt+Print { screenshot-window; }
        Ctrl+Alt+Delete { quit; }
        Ctrl+Print { screenshot-screen write-to-disk=false; }
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+A { focus-window-or-workspace-down; }
        Mod+Apostrophe { consume-window-into-column; }
        Mod+B { close-window; }
        Mod+BracketLeft { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }
        Mod+C { spawn "nautilus"; }
        Mod+Comma { focus-workspace-up; }
        Mod+Ctrl+A { focus-monitor-down; }
        Mod+Ctrl+Comma { move-workspace-up; }
        Mod+Ctrl+D { focus-monitor-up; }
        Mod+Ctrl+Down { focus-monitor-down; }
        Mod+Ctrl+E { focus-monitor-right; }
        Mod+Ctrl+F { expand-column-to-available-width; }
        Mod+Ctrl+H { focus-monitor-left; }
        Mod+Ctrl+L { reset-window-height; }
        Mod+Ctrl+Left { focus-monitor-left; }
        Mod+Ctrl+MouseBack { focus-monitor-left; }
        Mod+Ctrl+MouseForward { focus-monitor-right; }
        Mod+Ctrl+O { focus-monitor-up; }
        "Mod+Ctrl+Page_Down" { move-workspace-down; }
        "Mod+Ctrl+Page_Up" { move-workspace-up; }
        Mod+Ctrl+Period { move-workspace-down; }
        Mod+Ctrl+R { focus-monitor-left; }
        Mod+Ctrl+Right { focus-monitor-right; }
        Mod+Ctrl+S { focus-monitor-right; }
        Mod+Ctrl+Shift+A { move-column-to-monitor-down; }
        Mod+Ctrl+Shift+D { move-column-to-monitor-up; }
        Mod+Ctrl+Shift+Down { move-column-to-monitor-down; }
        Mod+Ctrl+Shift+E { move-column-to-monitor-right; }
        Mod+Ctrl+Shift+H { move-column-to-monitor-left; }
        Mod+Ctrl+Shift+Left { move-column-to-monitor-left; }
        Mod+Ctrl+Shift+MouseBack { move-column-to-monitor-left; }
        Mod+Ctrl+Shift+MouseForward { move-column-to-monitor-right; }
        Mod+Ctrl+Shift+O { move-column-to-monitor-up; }
        Mod+Ctrl+Shift+R { move-column-to-monitor-left; }
        Mod+Ctrl+Shift+Right { move-column-to-monitor-right; }
        Mod+Ctrl+Shift+S { move-column-to-monitor-right; }
        Mod+Ctrl+Shift+T { move-column-to-monitor-down; }
        Mod+Ctrl+Shift+Up { move-column-to-monitor-up; }
        Mod+Ctrl+Shift+WheelScrollDown { move-column-to-monitor-down; }
        Mod+Ctrl+Shift+WheelScrollLeft { move-column-to-monitor-left; }
        Mod+Ctrl+Shift+WheelScrollRight { move-column-to-monitor-right; }
        Mod+Ctrl+Shift+WheelScrollUp { move-column-to-monitor-up; }
        Mod+Ctrl+T { focus-monitor-down; }
        Mod+Ctrl+Up { focus-monitor-up; }
        Mod+Ctrl+WheelScrollDown { focus-monitor-down; }
        Mod+Ctrl+WheelScrollLeft { focus-monitor-left; }
        Mod+Ctrl+WheelScrollRight { focus-monitor-right; }
        Mod+Ctrl+WheelScrollUp { focus-monitor-up; }
        Mod+D { focus-window-or-workspace-up; }
        Mod+Down { focus-window-or-workspace-down; }
        Mod+E { focus-column-right; }
        Mod+End { focus-column-last; }
        Mod+Equal { set-column-width "+10%"; }
        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
        Mod+F { maximize-column; }
        Mod+H { focus-column-left; }
        Mod+Home { focus-column-first; }
        Mod+L { switch-preset-column-width; }
        Mod+Left { focus-column-left; }
        Mod+M { focus-window-previous; }
        Mod+Minus { set-column-width "-10%"; }
        Mod+MouseBack { focus-column-left; }
        Mod+MouseForward { focus-column-right; }
        Mod+O { focus-window-or-workspace-up; }
        "Mod+Page_Down" { focus-workspace-down; }
        "Mod+Page_Up" { focus-workspace-up; }
        Mod+Period { focus-workspace-down; }
        Mod+Q { close-window; }
        Mod+R { focus-column-left; }
        Mod+Return { spawn "sh" "-c" "ghostty --gtk-single-instance=true"; }
        Mod+Right { focus-column-right; }
        Mod+S { focus-column-right; }
        Mod+Semicolon { expel-window-from-column; }
        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }
        Mod+Shift+A { move-window-down; }
        Mod+Shift+B { quit; }
        Mod+Shift+Comma { move-column-to-workspace-up; }
        Mod+Shift+D { move-window-up; }
        Mod+Shift+Down { move-window-down; }
        Mod+Shift+E { move-column-right; }
        Mod+Shift+End { move-column-to-last; }
        Mod+Shift+Equal { set-window-height "+10%"; }
        Mod+Shift+F { fullscreen-window; }
        Mod+Shift+H { move-column-left; }
        Mod+Shift+Home { move-column-to-first; }
        Mod+Shift+L { switch-preset-window-height; }
        Mod+Shift+Left { move-column-left; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+MouseBack { move-column-left; }
        Mod+Shift+MouseForward { move-column-right; }
        Mod+Shift+O { move-window-up; }
        Mod+Shift+P { power-off-monitors; }
        "Mod+Shift+Page_Down" { move-column-to-workspace-down; }
        "Mod+Shift+Page_Up" { move-column-to-workspace-up; }
        Mod+Shift+Period { move-column-to-workspace-down; }
        Mod+Shift+R { move-column-left; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+S { move-column-right; }
        Mod+Shift+Slash { show-hotkey-overlay; }
        Mod+Shift+T { move-window-down; }
        Mod+Shift+Up { move-window-up; }
        Mod+Shift+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Shift+WheelScrollLeft { move-column-left; }
        Mod+Shift+WheelScrollRight { move-column-right; }
        Mod+Shift+WheelScrollUp cooldown-ms=150 { move-column-to-workspace-up; }
        Mod+Shift+Z { switch-focus-between-floating-and-tiling; }
        Mod+Slash repeat=false { spawn "set-wallpaper"; }
        Mod+Space { spawn "fuzzel"; }
        Mod+T { focus-window-or-workspace-down; }
        Mod+U repeat=false { toggle-overview; }
        Mod+Up { focus-window-or-workspace-up; }
        Mod+V { center-column; }
        Mod+W { toggle-column-tabbed-display; }
        Mod+WheelScrollDown cooldown-ms=150 { focus-window-or-workspace-down; }
        Mod+WheelScrollLeft { focus-column-left; }
        Mod+WheelScrollRight { focus-column-right; }
        Mod+WheelScrollUp cooldown-ms=150 { focus-window-or-workspace-up; }
        Mod+Z { toggle-window-floating; }
        Print { screenshot; }
        Super+Alt+L { spawn "swaylock"; }
        "XF86_AudioLowerVolume" allow-when-locked=true { spawn "sh" "-c" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"; }
        "XF86_AudioMicMute" allow-when-locked=true { spawn "sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
        "XF86_AudioMute" allow-when-locked=true { spawn "sh" "-c" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
        "XF86_AudioRaiseVolume" allow-when-locked=true { spawn "sh" "-c" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.5"; }
        "XF86_MonBrightnessDown" allow-when-locked=true { spawn "sh" "-c" "brightnessctl set 5%-"; }
        "XF86_MonBrightnessUp" allow-when-locked=true { spawn "sh" "-c" "brightnessctl set +5%"; }
    }
    spawn-at-startup "sh" "-c" "swaybg -i ~/.local/share/background"
    spawn-at-startup "xwayland-satellite"
    spawn-at-startup "ghostty" "--gtk-single-instance=true" "--quit-after-last-window-closed=false" "--initial-window=false"
    animations { slowdown 0.500000; }
  '';
  outputs = ''
    output "HDMI-A-1" {
        transform "normal"
        mode "1920x1080@100.000000"
    }
    output "eDP-1" {
        scale 1.250000
        transform "normal"
    }
  '';
  waitFrameCompletion = ''
    debug {
        wait-for-frame-completion-in-pipewire
    }
  '';
  finalConfig = ''
    ${baseConfig}
    ${if (config.hostname == "tigris") then outputs else ""}
    ${if (config.gpu == "nvidia") then waitFrameCompletion else ""}
  '';
in
{
  programs.niri.config = finalConfig;
}
