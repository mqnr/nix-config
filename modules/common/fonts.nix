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
        pkgs.noto-fonts
        pkgs.noto-fonts-cjk-sans
        pkgs.noto-fonts-emoji
        pkgs.aporetic
        pkgs.nerd-fonts.jetbrains-mono
      ];
    }

    (lib.mkIf config.isLinux { fonts.fontconfig.enable = true; })
  ];
}
