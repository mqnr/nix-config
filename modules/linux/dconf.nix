{ config, lib, ... }:

lib.mkIf config.isPC {
  programs.dconf.enable = true;

  home-manager.sharedModules = [
    {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          icon-theme = "Papirus-Dark";
        };
      };
    }
  ];
}
