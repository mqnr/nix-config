{ ... }:

{
  programs.niri.settings = {
    outputs = {
      "eDP-1".scale = 1.25;

      "HDMI-A-1".mode = {
        width = 1920;
        height = 1080;
        refresh = 100.0;
      };
    };
  };
}
