{ config, lib, ... }:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      programs.ghostty = {
        enable = true;
        settings = {
          command = "nu";
          font-family = "Aporetic Sans Mono";
          font-size = 18;
          background = "292c2f";
          background-opacity = 0.95;
          window-padding-x = 8;
        };
      };
    }
  ];
}
