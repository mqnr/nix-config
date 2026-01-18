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
          command = "${pkgs.nushell}/bin/nu";
          font-family = "Intel One Mono";
          font-size = 16;
          theme = "Catppuccin Mocha";
          background-opacity = 0.90;
          background-blur = config.isDarwin;
          window-padding-x = 8;
        };
      };
    }
  ];
}
