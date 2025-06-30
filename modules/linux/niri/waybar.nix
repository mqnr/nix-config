{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      layer = "top";

      margin-left  = 8;
      margin-right = 8;

      modules-left = [ "niri/workspaces" ];

      "niri/workspaces" = {
        format       = "{icon}";
        format-icons = {
          active  = " ";
          default = " ";
        };
      };

      modules-center = [ "niri/window" ];

      modules-right = ["tray" "battery" "pulseaudio" "clock" ];

      pulseaudio = {
        format       = "{format_source} {icon} {volume}%";
        format-muted = "{format_source} 󰸈 {volume}%";

        format-bluetooth       = "{format_source} 󰋋 󰂯 {volume}%";
        format-bluetooth-muted = "{format_source} 󰟎 󰂯 {volume}%";

        format-source       = "󰍬";
        format-source-muted = "󰍭";

        format-icons.default = [ "󰕿" "󰖀" "󰕾" ];
      };

      battery = {
        format          = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged  = "󰂄 {capacity}%";

        format-icons    = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];

        states = {
          warning  = 30;
          critical = 15;
        };
      };

      clock = {
        format         = "{:%a %Y-%m-%d %H:%M}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";

        calendar = {
          weeks-pos = "right";

          format = {
            weeks = "| W{}";
            today = "<b><u>{}</u></b>";
          };
        };
      };

      tray = {
        icon-size         = 17;
        spacing           = 10;
        reverse-direction = true;
      };
    };

    style = ./waybar-style.css;
  };
}
