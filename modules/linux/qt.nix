{ config, lib, ... }:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      qt = {
        enable = true;
        platformTheme.name = "gtk";
        style.name = "adwaita-dark";
      };
    }
  ];
}
