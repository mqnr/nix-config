{ config, lib, ... }:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      home.sessionVariables.BAT_PAGING = "never";
      programs.bat.enable = true;
    }
  ];
}
