{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      modules-left = [ "wlr/taskbar" ];
      modules-right = [
        "tray"
        "battery"
        "wireplumber"
        "clock"
      ];
      "wlr/taskbar" = {
        format = "{icon}";
        icon-size = 14;
        icon-theme = "Numix-Circle";
        tooltip-format = "{title}";
        on-click = "activate";
      };
      clock = {
        format = "{:%a %Y-%m-%d %H:%M}";
        tooltip = false;
      };
      tray = {
        icon-size = 17;
        spacing = 10;
        reverse-direction = true;
      };
    };
  };
}
