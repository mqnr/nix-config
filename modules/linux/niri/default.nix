{ lib, config, ... }:

{
  imports = [
    ./gtkgreet.nix
    ./waybar.nix
  ];

  programs.niri.settings = {
    prefer-no-csd = true;

    input = {
      keyboard.xkb.layout = "tangent-gallium";

      touchpad = {
        tap            = true;
        dwt            = true;
        natural-scroll = true;
      };

      mouse.accel-profile = "flat";
    };

    outputs = {
      "eDP-1".scale = 1.25;

      "HDMI-A-1".mode = {
        width   = 1920;
        height  = 1080;
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
      DISPLAY                     = ":0";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };

    layout.focus-ring.active.color = "#a6c18b";

    binds = with config.lib.niri.actions; let
      sh                   = spawn "sh" "-c";
      sh-allow-locked      = command: { action = sh command; allow-when-locked = true; };
      with-150-ms-cooldown = action: { inherit action; cooldown-ms = 150; };

      workspaceBindings = lib.range 1 9
        |> builtins.concatMap (i: let si = toString i; in [
          { name = "Mod+${si}"; value = { action = focus-workspace i; }; }
          { name = "Mod+Shift+${si}"; value = { action.move-column-to-workspace = i; }; }
        ])
        |> builtins.listToAttrs;
    in {
      "Mod+Shift+Slash".action = show-hotkey-overlay;

      "Mod+Return".action = sh "ghostty --gtk-single-instance=true";
      "Mod+Space".action  = spawn "fuzzel";
      "Alt+F3".action             = spawn "fuzzel";
      "Super+Alt+L".action        = spawn "swaylock";

      "Mod+D".action = spawn "pcmanfm-qt";

      "XF86_AudioRaiseVolume" = sh-allow-locked "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.5";
      "XF86_AudioLowerVolume" = sh-allow-locked "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
      "XF86_AudioMute"        = sh-allow-locked "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      "XF86_AudioMicMute"     = sh-allow-locked "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

      "XF86_MonBrightnessUp"   = sh-allow-locked "brightnessctl set +5%";
      "XF86_MonBrightnessDown" = sh-allow-locked "brightnessctl set 5%-";

      "Alt+F4".action        = close-window;
      "Mod+Q".action = close-window;
      "Mod+B".action = close-window; # oBliterate

      # Uvierview
      "Mod+U" = {
        action = toggle-overview;
        repeat = false;
      };

      "Mod+M".action = focus-window-previous;

      "Mod+Left".action  = focus-column-left;
      "Mod+Down".action  = focus-window-or-workspace-down;
      "Mod+Up".action    = focus-window-or-workspace-up;
      "Mod+Right".action = focus-column-right;
      "Mod+H".action     = focus-column-left;
      "Mod+A".action     = focus-window-or-workspace-down;
      "Mod+O".action     = focus-window-or-workspace-up;
      "Mod+E".action     = focus-column-right;
      "Mod+N".action     = focus-column-left;
      "Mod+R".action     = focus-window-or-workspace-down;
      "Mod+L".action     = focus-window-or-workspace-up;
      "Mod+T".action     = focus-column-right;

      "Mod+Shift+Left".action  = move-column-left;
      "Mod+Shift+Down".action  = move-window-down;
      "Mod+Shift+Up".action    = move-window-up;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+H".action     = move-column-left;
      "Mod+Shift+A".action     = move-window-down;
      "Mod+Shift+O".action     = move-window-up;
      "Mod+Shift+E".action     = move-column-right;
      "Mod+Shift+N".action     = move-column-left;
      "Mod+Shift+R".action     = move-window-down;
      "Mod+Shift+L".action     = move-window-up;
      "Mod+Shift+T".action     = move-column-right;

      "Mod+Home".action       = focus-column-first;
      "Mod+End".action        = focus-column-last;
      "Mod+Shift+Home".action = move-column-to-first;
      "Mod+Shift+End".action  = move-column-to-last;

      "Mod+Ctrl+Left".action        = focus-monitor-left;
      "Mod+Ctrl+Down".action        = focus-monitor-down;
      "Mod+Ctrl+Up".action          = focus-monitor-up;
      "Mod+Ctrl+Right".action       = focus-monitor-right;
      "Mod+Ctrl+H".action           = focus-monitor-left;
      "Mod+Ctrl+A".action           = focus-monitor-down;
      "Mod+Ctrl+O".action           = focus-monitor-up;
      "Mod+Ctrl+E".action           = focus-monitor-right;
      "Mod+Ctrl+N".action           = focus-monitor-left;
      "Mod+Ctrl+R".action           = focus-monitor-down;
      "Mod+Ctrl+L".action           = focus-monitor-up;
      "Mod+Ctrl+T".action           = focus-monitor-right;
      "Mod+Ctrl+Shift+Left".action  = move-column-to-monitor-left;
      "Mod+Ctrl+Shift+Down".action  = move-column-to-monitor-down;
      "Mod+Ctrl+Shift+Up".action    = move-column-to-monitor-up;
      "Mod+Ctrl+Shift+Right".action = move-column-to-monitor-right;
      "Mod+Ctrl+Shift+H".action     = move-column-to-monitor-left;
      "Mod+Ctrl+Shift+A".action     = move-column-to-monitor-down;
      "Mod+Ctrl+Shift+O".action     = move-column-to-monitor-up;
      "Mod+Ctrl+Shift+E".action     = move-column-to-monitor-right;
      "Mod+Ctrl+Shift+N".action     = move-column-to-monitor-left;
      "Mod+Ctrl+Shift+R".action     = move-column-to-monitor-down;
      "Mod+Ctrl+Shift+L".action     = move-column-to-monitor-up;
      "Mod+Ctrl+Shift+T".action     = move-column-to-monitor-right;

      "Mod+Page_Down".action       = focus-workspace-down;
      "Mod+Page_Up".action         = focus-workspace-up;
      "Mod+Period".action          = focus-workspace-down;
      "Mod+Comma".action           = focus-workspace-up;
      "Mod+Shift+Page_Down".action = move-column-to-workspace-down;
      "Mod+Shift+Page_Up".action   = move-column-to-workspace-up;
      "Mod+Shift+Period".action    = move-column-to-workspace-down;
      "Mod+Shift+Comma".action     = move-column-to-workspace-up;

      "Mod+Ctrl+Page_Down".action = move-workspace-down;
      "Mod+Ctrl+Page_Up".action   = move-workspace-up;
      "Mod+Ctrl+Period".action    = move-workspace-down;
      "Mod+Ctrl+Comma".action     = move-workspace-up;

      "Mod+WheelScrollRight".action            = focus-column-right;
      "Mod+WheelScrollLeft".action             = focus-column-left;
      "Mod+Shift+WheelScrollRight".action      = move-column-right;
      "Mod+Shift+WheelScrollLeft".action       = move-column-left;
      "Mod+Ctrl+WheelScrollLeft".action        = focus-monitor-left;
      "Mod+Ctrl+WheelScrollRight".action       = focus-monitor-right;
      "Mod+Ctrl+Shift+WheelScrollRight".action = move-column-to-monitor-right;
      "Mod+Ctrl+Shift+WheelScrollLeft".action  = move-column-to-monitor-left;

      "Mod+WheelScrollDown"       = with-150-ms-cooldown focus-window-or-workspace-down;
      "Mod+WheelScrollUp"         = with-150-ms-cooldown focus-window-or-workspace-up;
      "Mod+Shift+WheelScrollDown" = with-150-ms-cooldown move-column-to-workspace-down;
      "Mod+Shift+WheelScrollUp"   = with-150-ms-cooldown move-column-to-workspace-up;

      "Mod+Ctrl+WheelScrollDown".action       = focus-monitor-down;
      "Mod+Ctrl+WheelScrollUp".action         = focus-monitor-up;
      "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-to-monitor-down;
      "Mod+Ctrl+Shift+WheelScrollUp".action   = move-column-to-monitor-up;

      "Mod+MouseBack".action               = focus-column-left;
      "Mod+MouseForward".action            = focus-column-right;
      "Mod+Shift+MouseBack".action         = move-column-left;
      "Mod+Shift+MouseForward".action      = move-column-right;
      "Mod+Ctrl+MouseBack".action          = focus-monitor-left;
      "Mod+Ctrl+MouseForward".action       = focus-monitor-right;
      "Mod+Ctrl+Shift+MouseBack".action    = move-column-to-monitor-left;
      "Mod+Ctrl+Shift+MouseForward".action = move-column-to-monitor-right;

      "Mod+BracketLeft".action  = consume-or-expel-window-left;
      "Mod+BracketRight".action = consume-or-expel-window-right;

      "Mod+Apostrophe".action = consume-window-into-column;
      "Mod+Semicolon".action  = expel-window-from-column;

      "Mod+C".action       = switch-preset-column-width;
      "Mod+Shift+C".action = switch-preset-window-height;
      "Mod+Ctrl+C".action  = reset-window-height;
      "Mod+F".action       = maximize-column;
      "Mod+Shift+F".action = fullscreen-window;

      "Mod+Ctrl+F".action = expand-column-to-available-width;

      "Mod+V".action = center-column;

      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Equal".action = set-column-width "+10%";

      "Mod+Shift+Minus".action = set-window-height "-10%";
      "Mod+Shift+Equal".action = set-window-height "+10%";

      "Mod+Z".action       = toggle-window-floating;
      "Mod+Shift+Z".action = switch-focus-between-floating-and-tiling;

      "Mod+W".action = toggle-column-tabbed-display;

      "Print".action                        = screenshot;
      "Ctrl+Print".action.screenshot-screen = { write-to-disk = false; };
      "Alt+Print".action                    = screenshot-window;

      "Mod+Escape" = {
        action = toggle-keyboard-shortcuts-inhibit;
        allow-inhibiting = false;
      };

      "Mod+Shift+D".action = quit;
      "Ctrl+Alt+Delete".action     = quit;

      "Mod+Shift+P".action = power-off-monitors;
    } // workspaceBindings;
  };
}
