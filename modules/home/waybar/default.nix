{ ... }:

{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      modules-right = [
        "tray"
        "battery"
        "wireplumber"
        "clock"
      ];
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
    style = ./style.css;
  };
}
