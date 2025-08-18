{ config, lib, ... }:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      services.gammastep = {
        enable = true;
        provider = "geoclue2";
        temperature = {
          day = 6500;
          night = 3500;
        };
      };
    }
  ];
}
