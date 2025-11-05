{ config, lib, ... }:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      programs.nushell = {
        enable = true;
        configFile.source = ./config.nu;
      };
    }
    (lib.mkIf config.isDarwin {
      programs.nushell.envFile.source = ./env.nu;
    })
  ];
}
