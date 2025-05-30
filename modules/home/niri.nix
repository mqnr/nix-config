{ config, ... }:

{
  programs.niri = {
    settings = {
      input = {
        keyboard.xkb.layout = "tangent-gallium";
        touchpad = {
          tap = true;
          dwt = true;
          natural-scroll = true;
        };
        mouse.accel-profile = "flat";
      };
      outputs."eDP-1".scale = 1.25;
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
      binds = with config.lib.niri.actions; let
        modifier = "Mod";
        sh = spawn "sh" "-c";
      in {
        "${modifier}+Shift+Slash".action = show-hotkey-overlay;

        "${modifier}+Return".action = sh "ghostty --gtk-single-instance=true";
        "${modifier}+S".action = spawn "fuzzel";
        "Super+Alt+L".action = spawn "swaylock";

        "XF86AudioRaiseVolume" = {
          action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.5";
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action = sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          allow-when-locked = true;
        };

        # oBliterate
        "${modifier}+B".action = close-window;

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

        "${modifier}+Ctrl+Left".action = move-column-left;
        "${modifier}+Ctrl+Down".action = move-window-down;
        "${modifier}+Ctrl+Up".action = move-window-up;
        "${modifier}+Ctrl+Right".action = move-column-right;
        "${modifier}+Ctrl+H".action = move-column-left;
        "${modifier}+Ctrl+A".action = move-window-down;
        "${modifier}+Ctrl+O".action = move-window-up;
        "${modifier}+Ctrl+E".action = move-column-right;
        "${modifier}+Ctrl+N".action = move-column-left;
        "${modifier}+Ctrl+R".action = move-window-down;
        "${modifier}+Ctrl+L".action = move-window-up;
        "${modifier}+Ctrl+T".action = move-column-right;

        "${modifier}+Home".action = focus-column-first;
        "${modifier}+End".action = focus-column-last;
        "${modifier}+Ctrl+Home".action = move-column-to-first;
        "${modifier}+Ctrl+End".action = move-column-to-last;

        "${modifier}+Shift+Left".action = focus-monitor-left;
        "${modifier}+Shift+Down".action = focus-monitor-down;
        "${modifier}+Shift+Up".action = focus-monitor-up;
        "${modifier}+Shift+Right".action = focus-monitor-right;
        "${modifier}+Shift+H".action = focus-monitor-left;
        "${modifier}+Shift+A".action = focus-monitor-down;
        "${modifier}+Shift+O".action = focus-monitor-up;
        "${modifier}+Shift+E".action = focus-monitor-right;
        "${modifier}+Shift+N".action = focus-monitor-left;
        "${modifier}+Shift+R".action = focus-monitor-down;
        "${modifier}+Shift+L".action = focus-monitor-up;
        "${modifier}+Shift+T".action = focus-monitor-right;
        "${modifier}+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "${modifier}+Shift+Ctrl+Down".action = move-column-to-monitor-down;
        "${modifier}+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "${modifier}+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "${modifier}+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "${modifier}+Shift+Ctrl+A".action = move-column-to-monitor-down;
        "${modifier}+Shift+Ctrl+O".action = move-column-to-monitor-up;
        "${modifier}+Shift+Ctrl+E".action = move-column-to-monitor-right;
        "${modifier}+Shift+Ctrl+N".action = move-column-to-monitor-left;
        "${modifier}+Shift+Ctrl+R".action = move-column-to-monitor-down;
        "${modifier}+Shift+Ctrl+L".action = move-column-to-monitor-up;
        "${modifier}+Shift+Ctrl+T".action = move-column-to-monitor-right;

        "${modifier}+Page_Down".action = focus-workspace-down;
        "${modifier}+Page_Up".action = focus-workspace-up;
        "${modifier}+U".action = focus-workspace-down;
        "${modifier}+Comma".action = focus-workspace-up;
        "${modifier}+Ctrl+Page_Down".action = move-column-to-workspace-down;
        "${modifier}+Ctrl+Page_Up".action = move-column-to-workspace-up;
        "${modifier}+Ctrl+U".action = move-column-to-workspace-down;
        "${modifier}+Ctrl+Comma".action = move-column-to-workspace-up;

        "${modifier}+Shift+Page_Down".action = move-workspace-down;
        "${modifier}+Shift+Page_Up".action = move-workspace-up;
        "${modifier}+Shift+U".action = move-workspace-down;
        "${modifier}+Shift+Comma".action = move-workspace-up;

        "${modifier}+WheelScrollDown" = {
          action = focus-workspace-down;
          cooldown-ms = 150;
        };
        "${modifier}+WheelScrollUp" = {
          action = focus-workspace-up;
          cooldown-ms = 150;
        };
        "${modifier}+Ctrl+WheelScrollDown" = {
          action = move-column-to-workspace-down;
          cooldown-ms = 150;
        };
        "${modifier}+Ctrl+WheelScrollUp" = {
          action = move-column-to-workspace-up;
          cooldown-ms = 150;
        };

        "${modifier}+WheelScrollRight".action = focus-column-right;
        "${modifier}+WheelScrollLeft".action = focus-column-left;
        "${modifier}+Ctrl+WheelScrollRight".action = move-column-right;
        "${modifier}+Ctrl+WheelScrollLeft".action = move-column-left;

        "${modifier}+Shift+WheelScrollDown".action = focus-column-right;
        "${modifier}+Shift+WheelScrollUp".action = focus-column-left;
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
        "${modifier}+Ctrl+1".action.move-column-to-workspace = 1;
        "${modifier}+Ctrl+2".action.move-column-to-workspace = 2;
        "${modifier}+Ctrl+3".action.move-column-to-workspace = 3;
        "${modifier}+Ctrl+4".action.move-column-to-workspace = 4;
        "${modifier}+Ctrl+5".action.move-column-to-workspace = 5;
        "${modifier}+Ctrl+6".action.move-column-to-workspace = 6;
        "${modifier}+Ctrl+7".action.move-column-to-workspace = 7;
        "${modifier}+Ctrl+8".action.move-column-to-workspace = 8;
        "${modifier}+Ctrl+9".action.move-column-to-workspace = 9;

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

        "${modifier}+D".action = center-column;

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
