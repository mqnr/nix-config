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
          background-opacity = 0.9;
        };
      };
    }
  ];
}
