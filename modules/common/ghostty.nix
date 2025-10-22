{ config, lib, ... }:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      programs.ghostty = {
        enable = true;
        settings = {
          command = "nu";
          font-family = "Intel One Mono";
          font-size = 16;
          theme = "Catppuccin Mocha";
          background-opacity = 0.93;
          window-padding-x = 8;
        };
      };
    }
  ];
}
