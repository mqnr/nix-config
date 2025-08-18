{ config, lib, ... }:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      programs.mpv = {
        enable = true;
        bindings = {
          r = "cycle_values video-rotate 90 180 270 0";
        };
      };
    }
  ];
}
