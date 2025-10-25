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
          command = if config.isLinux then "${pkgs.nushell}/bin/nu" else "fish";
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
