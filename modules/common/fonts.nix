{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      home.packages = [
        pkgs.aporetic
        pkgs.nerd-fonts.jetbrains-mono
      ];
    }

    (lib.mkIf config.isLinux { fonts.fontconfig.enable = true; })
  ];
}
