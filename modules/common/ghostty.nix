{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      programs.ghostty = {
        enable = true;
        package = lib.mkIf config.isDarwin null;
        settings = {
          command = lib.mkIf config.isLinux "${pkgs.nushell}/bin/nu";
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
