{ config, ... }:

{
  imports = [
    ./gtkgreet.nix
    ./waybar.nix
  ];

  programs.niri = {
    settings = {
      prefer-no-csd = true;
      input = {
        keyboard.xkb.layout = "tangent-gallium";
        touchpad = {
          tap = true;
          dwt = true;
          natural-scroll = true;
        };
        mouse.accel-profile = "flat";
      };
      outputs = {
        "eDP-1".scale = 1.25;
        "HDMI-A-1".mode = {
          width = 1920;
          height = 1080;
          refresh = 100.0;
        };
      };
      animations.slowdown = 0.5;
      spawn-at-startup = [
        # do this better?
        { command = [ "sh" "-c" "swaybg -i ~/.local/share/background" ]; }
        { command = [ "xwayland-satellite" ]; }
        { command = [
            "ghostty"
            "--gtk-single-instance=true"
            "--quit-after-last-window-closed=false"
            "--initial-window=false"
          ]; }
      ];
      environment = {
        DISPLAY = ":0";
        _JAVA_AWT_WM_NONREPARENTING = "1";
      };
      layout.focus-ring.active.color = "#a6c18b";
      binds = with config.lib.niri.actions; let
        modifier = "Mod";
        sh = spawn "sh" "-c";
      in {
        "${modifier}+Shift+Slash".action = show-hotkey-overlay;

        "${modifier}+Return".action = sh "ghostty --gtk-single-instance=true";
        "${modifier}+Space".action = spawn "fuzzel";
        "Alt+F3".action = spawn "fuzzel";
        "Super+Alt+L".action = spawn "swaylock";

        "${modifier}+D".action = spawn "pcmanfm-qt";

        "XF86_AudioRaiseVolume" = {
          action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.5";
          allow-when-locked = true;
        };
        "XF86_AudioLowerVolume" = {
          action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
          allow-when-locked = true;
        };
        "XF86_AudioMute" = {
          action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          allow-when-locked = true;
        };
        "XF86_AudioMicMute" = {
          action = sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          allow-when-locked = true;
        };

        "XF86_MonBrightnessUp" = {
          action = sh "brightnessctl set +5%";
          allow-when-locked = true;
        };
        "XF86_MonBrightnessDown" = {
          action = sh "brightnessctl set 5%-";
          allow-when-locked = true;
        };

        "Alt+F4".action = close-window;
        "${modifier}+Q".action = close-window;
        # oBliterate
        "${modifier}+B".action = close-window;

        # Uvierview
        "${modifier}+U" = {
          action = toggle-overview;
          repeat = false;
        };

        "${modifier}+M".action = focus-window-previous;

        "${modifier}+Left".action = focus-column-left;
        "${modifier}+Down".action = focus-window-or-workspace-down;
        "${modifier}+Up".action = focus-window-or-workspace-up;
        "${modifier}+Right".action = focus-column-right;
        "${modifier}+H".action = focus-column-left;
        "${modifier}+A".action = focus-window-or-workspace-down;
        "${modifier}+O".action = focus-window-or-workspace-up;
        "${modifier}+E".action = focus-column-right;
        "${modifier}+N".action = focus-column-left;
        "${modifier}+R".action = focus-window-or-workspace-down;
        "${modifier}+L".action = focus-window-or-workspace-up;
        "${modifier}+T".action = focus-column-right;

        "${modifier}+Shift+Left".action = move-column-left;
        "${modifier}+Shift+Down".action = move-window-down;
        "${modifier}+Shift+Up".action = move-window-up;
        "${modifier}+Shift+Right".action = move-column-right;
        "${modifier}+Shift+H".action = move-column-left;
        "${modifier}+Shift+A".action = move-window-down;
        "${modifier}+Shift+O".action = move-window-up;
        "${modifier}+Shift+E".action = move-column-right;
        "${modifier}+Shift+N".action = move-column-left;
        "${modifier}+Shift+R".action = move-window-down;
        "${modifier}+Shift+L".action = move-window-up;
        "${modifier}+Shift+T".action = move-column-right;

        "${modifier}+Home".action = focus-column-first;
        "${modifier}+End".action = focus-column-last;
        "${modifier}+Shift+Home".action = move-column-to-first;
        "${modifier}+Shift+End".action = move-column-to-last;

        "${modifier}+Ctrl+Left".action = focus-monitor-left;
        "${modifier}+Ctrl+Down".action = focus-monitor-down;
        "${modifier}+Ctrl+Up".action = focus-monitor-up;
        "${modifier}+Ctrl+Right".action = focus-monitor-right;
        "${modifier}+Ctrl+H".action = focus-monitor-left;
        "${modifier}+Ctrl+A".action = focus-monitor-down;
        "${modifier}+Ctrl+O".action = focus-monitor-up;
        "${modifier}+Ctrl+E".action = focus-monitor-right;
        "${modifier}+Ctrl+N".action = focus-monitor-left;
        "${modifier}+Ctrl+R".action = focus-monitor-down;
        "${modifier}+Ctrl+L".action = focus-monitor-up;
        "${modifier}+Ctrl+T".action = focus-monitor-right;
        "${modifier}+Ctrl+Shift+Left".action = move-column-to-monitor-left;
        "${modifier}+Ctrl+Shift+Down".action = move-column-to-monitor-down;
        "${modifier}+Ctrl+Shift+Up".action = move-column-to-monitor-up;
        "${modifier}+Ctrl+Shift+Right".action = move-column-to-monitor-right;
        "${modifier}+Ctrl+Shift+H".action = move-column-to-monitor-left;
        "${modifier}+Ctrl+Shift+A".action = move-column-to-monitor-down;
        "${modifier}+Ctrl+Shift+O".action = move-column-to-monitor-up;
        "${modifier}+Ctrl+Shift+E".action = move-column-to-monitor-right;
        "${modifier}+Ctrl+Shift+N".action = move-column-to-monitor-left;
        "${modifier}+Ctrl+Shift+R".action = move-column-to-monitor-down;
        "${modifier}+Ctrl+Shift+L".action = move-column-to-monitor-up;
        "${modifier}+Ctrl+Shift+T".action = move-column-to-monitor-right;

        "${modifier}+Page_Down".action = focus-workspace-down;
        "${modifier}+Page_Up".action = focus-workspace-up;
        "${modifier}+Period".action = focus-workspace-down;
        "${modifier}+Comma".action = focus-workspace-up;
        "${modifier}+Shift+Page_Down".action = move-column-to-workspace-down;
        "${modifier}+Shift+Page_Up".action = move-column-to-workspace-up;
        "${modifier}+Shift+Period".action = move-column-to-workspace-down;
        "${modifier}+Shift+Comma".action = move-column-to-workspace-up;

        "${modifier}+Ctrl+Page_Down".action = move-workspace-down;
        "${modifier}+Ctrl+Page_Up".action = move-workspace-up;
        "${modifier}+Ctrl+Period".action = move-workspace-down;
        "${modifier}+Ctrl+Comma".action = move-workspace-up;

        "${modifier}+WheelScrollDown" = {
          action = focus-workspace-down;
          cooldown-ms = 150;
        };
        "${modifier}+WheelScrollUp" = {
          action = focus-workspace-up;
          cooldown-ms = 150;
        };
        "${modifier}+Shift+WheelScrollDown" = {
          action = move-column-to-workspace-down;
          cooldown-ms = 150;
        };
        "${modifier}+Shift+WheelScrollUp" = {
          action = move-column-to-workspace-up;
          cooldown-ms = 150;
        };

        "${modifier}+WheelScrollRight".action = focus-column-right;
        "${modifier}+WheelScrollLeft".action = focus-column-left;
        "${modifier}+Shift+WheelScrollRight".action = move-column-right;
        "${modifier}+Shift+WheelScrollLeft".action = move-column-left;

        "${modifier}+Ctrl+WheelScrollDown".action = focus-column-right;
        "${modifier}+Ctrl+WheelScrollUp".action = focus-column-left;
        "${modifier}+Ctrl+Shift+WheelScrollDown".action = move-column-right;
        "${modifier}+Ctrl+Shift+WheelScrollUp".action = move-column-left;

        "${modifier}+1".action = focus-workspace 1;
        "${modifier}+2".action = focus-workspace 2;
        "${modifier}+3".action = focus-workspace 3;
        "${modifier}+4".action = focus-workspace 4;
        "${modifier}+5".action = focus-workspace 5;
        "${modifier}+6".action = focus-workspace 6;
        "${modifier}+7".action = focus-workspace 7;
        "${modifier}+8".action = focus-workspace 8;
        "${modifier}+9".action = focus-workspace 9;
        "${modifier}+Shift+1".action.move-column-to-workspace = 1;
        "${modifier}+Shift+2".action.move-column-to-workspace = 2;
        "${modifier}+Shift+3".action.move-column-to-workspace = 3;
        "${modifier}+Shift+4".action.move-column-to-workspace = 4;
        "${modifier}+Shift+5".action.move-column-to-workspace = 5;
        "${modifier}+Shift+6".action.move-column-to-workspace = 6;
        "${modifier}+Shift+7".action.move-column-to-workspace = 7;
        "${modifier}+Shift+8".action.move-column-to-workspace = 8;
        "${modifier}+Shift+9".action.move-column-to-workspace = 9;

        "${modifier}+BracketLeft".action = consume-or-expel-window-left;
        "${modifier}+BracketRight".action = consume-or-expel-window-right;

        "${modifier}+Apostrophe".action = consume-window-into-column;
        "${modifier}+Semicolon".action = expel-window-from-column;

        "${modifier}+C".action = switch-preset-column-width;
        "${modifier}+Shift+C".action = switch-preset-window-height;
        "${modifier}+Ctrl+C".action = reset-window-height;
        "${modifier}+F".action = maximize-column;
        "${modifier}+Shift+F".action = fullscreen-window;

        "${modifier}+Ctrl+F".action = expand-column-to-available-width;

        "${modifier}+V".action = center-column;

        "${modifier}+Minus".action = set-column-width "-10%";
        "${modifier}+Equal".action = set-column-width "+10%";

        "${modifier}+Shift+Minus".action = set-window-height "-10%";
        "${modifier}+Shift+Equal".action = set-window-height "+10%";

        "${modifier}+Z".action = toggle-window-floating;
        "${modifier}+Shift+Z".action = switch-focus-between-floating-and-tiling;

        "${modifier}+W".action = toggle-column-tabbed-display;

        "Print".action = screenshot;
        "Ctrl+Print".action.screenshot-screen = { write-to-disk = false; };
        "Alt+Print".action = screenshot-window;

        "${modifier}+Escape" = {
          action = toggle-keyboard-shortcuts-inhibit;
          allow-inhibiting = false;
        };

        "${modifier}+Shift+D".action = quit;
        "Ctrl+Alt+Delete".action = quit;

        "${modifier}+Shift+P".action = power-off-monitors;
      };
    };
  };
}
